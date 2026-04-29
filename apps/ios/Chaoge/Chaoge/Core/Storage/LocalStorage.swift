import Foundation

actor LocalStorage {
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

    func load<T: Decodable>(_ type: T.Type, forKey key: String) throws -> T? {
        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }
        return try decoder.decode(type, from: data)
    }

    func removeValue(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }

    func saveArray<T: Encodable>(_ values: [T], forKey key: String) throws {
        try save(values, forKey: key)
    }

    func loadArray<T: Decodable>(_ type: T.Type, forKey key: String) throws -> [T] {
        try load([T].self, forKey: key) ?? []
    }
}
