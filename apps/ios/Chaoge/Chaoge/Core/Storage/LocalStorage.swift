import Foundation

actor LocalStorage {
    enum Key: String, CaseIterable, Sendable {
        case currentUser
        case agents
        case devices
        case sessions
        case projects
        case tasks
        case messages
    }

    static let shared = LocalStorage()

    private let userDefaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        self.encoder = encoder

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder
    }

    func save<T: Encodable>(_ value: T, forKey key: String) throws {
        let data = try encoder.encode(value)
        userDefaults.set(data, forKey: key)
    }

    func save<T: Encodable>(_ value: T, for key: Key) throws {
        try save(value, forKey: key.rawValue)
    }

    func load<T: Decodable>(_ type: T.Type, forKey key: String) throws -> T? {
        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }
        return try decoder.decode(type, from: data)
    }

    func load<T: Decodable>(_ type: T.Type, for key: Key) throws -> T? {
        try load(type, forKey: key.rawValue)
    }

    func removeValue(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }

    func removeValue(for key: Key) {
        removeValue(forKey: key.rawValue)
    }

    func saveArray<T: Encodable>(_ values: [T], forKey key: String) throws {
        try save(values, forKey: key)
    }

    func loadArray<T: Decodable>(_ type: T.Type, forKey key: String) throws -> [T] {
        try load([T].self, forKey: key) ?? []
    }

    func clearAll() {
        Key.allCases.forEach { removeValue(for: $0) }
    }
}
