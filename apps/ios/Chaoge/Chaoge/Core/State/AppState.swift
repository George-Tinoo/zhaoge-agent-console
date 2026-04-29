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

    func setError(_ message: String?) {
        lastErrorMessage = message
    }
}
