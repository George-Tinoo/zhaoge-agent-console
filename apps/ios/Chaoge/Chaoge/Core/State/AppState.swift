import Combine
import Foundation

@MainActor
final class AppState: ObservableObject {
    @Published var currentUser: User?
    @Published var agents: [Agent]
    @Published var devices: [Device]
    @Published var sessions: [Session]
    @Published var projects: [Project]
    @Published var tasks: [TaskItem]
    @Published var isLoading: Bool
    @Published var lastErrorMessage: String?

    var supervisor: Agent? {
        agents.first(where: \.isSupervisor)
    }

    var onlineDevices: [Device] {
        devices.filter(\.isReachable)
    }

    var activeProjects: [Project] {
        projects.filter(\.isOpen)
    }

    var pendingTasks: [TaskItem] {
        tasks.filter { !$0.isTerminal }
            .sorted { $0.priority > $1.priority }
    }

    init(
        currentUser: User? = nil,
        agents: [Agent] = [],
        devices: [Device] = [],
        sessions: [Session] = [],
        projects: [Project] = [],
        tasks: [TaskItem] = [],
        isLoading: Bool = false,
        lastErrorMessage: String? = nil
    ) {
        self.currentUser = currentUser
        self.agents = agents
        self.devices = devices
        self.sessions = sessions
        self.projects = projects
        self.tasks = tasks
        self.isLoading = isLoading
        self.lastErrorMessage = lastErrorMessage
    }

    func setUser(_ user: User?) {
        currentUser = user
    }

    func upsertAgent(_ agent: Agent) {
        upsert(agent, in: &agents)
    }

    func upsertDevice(_ device: Device) {
        upsert(device, in: &devices)
    }

    func upsertSession(_ session: Session) {
        upsert(session, in: &sessions)
    }

    func upsertProject(_ project: Project) {
        upsert(project, in: &projects)
    }

    func upsertTask(_ task: TaskItem) {
        upsert(task, in: &tasks)
    }

    func setLoading(_ loading: Bool) {
        isLoading = loading
    }

    func setError(_ message: String?) {
        lastErrorMessage = message
    }

    func clearError() {
        lastErrorMessage = nil
    }

    func persist(to storage: LocalStorage = .shared) async throws {
        try await storage.save(currentUser, for: .currentUser)
        try await storage.save(agents, for: .agents)
        try await storage.save(devices, for: .devices)
        try await storage.save(sessions, for: .sessions)
        try await storage.save(projects, for: .projects)
        try await storage.save(tasks, for: .tasks)
    }

    private func upsert<T: Identifiable & Equatable>(_ value: T, in collection: inout [T]) where T.ID == String {
        if let index = collection.firstIndex(where: { $0.id == value.id }) {
            collection[index] = value
        } else {
            collection.append(value)
        }
    }
}
