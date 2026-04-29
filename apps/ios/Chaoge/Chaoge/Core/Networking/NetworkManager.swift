import Combine
import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int, body: String?)
    case decodingFailed
}

final class NetworkManager: ObservableObject {
    static let shared = NetworkManager()

    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init(
        baseURL: URL = URL(string: "https://api.chaoge.ai/v1")!,
        session: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.session = session

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        self.encoder = encoder
    }

    func request<T: Decodable>(
        _ endpoint: String,
        method: String = "GET",
        headers: [String: String] = [:]
    ) async throws -> T {
        try await request(endpoint, method: method, body: nil as Data?, headers: headers)
    }

    func request<T: Decodable, Body: Encodable>(
        _ endpoint: String,
        method: String = "POST",
        body: Body,
        headers: [String: String] = [:]
    ) async throws -> T {
        let data = try encoder.encode(body)
        return try await request(endpoint, method: method, body: data, headers: headers)
    }

    private func request<T: Decodable>(
        _ endpoint: String,
        method: String,
        body: Data?,
        headers: [String: String]
    ) async throws -> T {
        guard let url = URL(string: endpoint, relativeTo: baseURL) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if body != nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(
                statusCode: httpResponse.statusCode,
                body: String(data: data, encoding: .utf8)
            )
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
