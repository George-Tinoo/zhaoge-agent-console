import Combine
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

enum HTTPMethod: String, Sendable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum NetworkError: Error, Equatable, LocalizedError, Sendable {
    case invalidURL(String)
    case invalidResponse
    case serverError(statusCode: Int, body: String?)
    case decodingFailed(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL(let endpoint): return "Invalid endpoint: \(endpoint)"
        case .invalidResponse: return "Server returned a non-HTTP response."
        case .serverError(let statusCode, let body): return "Server error \(statusCode): \(body ?? "<empty>")"
        case .decodingFailed(let reason): return "Failed to decode response: \(reason)"
        }
    }
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
        method: HTTPMethod = .get,
        headers: [String: String] = [:]
    ) async throws -> T {
        try await request(endpoint, method: method, body: nil as Data?, headers: headers)
    }

    func request<T: Decodable, Body: Encodable>(
        _ endpoint: String,
        method: HTTPMethod = .post,
        body: Body,
        headers: [String: String] = [:]
    ) async throws -> T {
        let data = try encoder.encode(body)
        return try await request(endpoint, method: method, body: data, headers: headers)
    }

    func request<T: Codable, Body: Codable>(
        _ endpoint: String,
        method: HTTPMethod = .post,
        codableBody body: Body,
        headers: [String: String] = [:]
    ) async throws -> T {
        try await request(endpoint, method: method, body: body, headers: headers)
    }

    private func request<T: Decodable>(
        _ endpoint: String,
        method: HTTPMethod,
        body: Data?,
        headers: [String: String]
    ) async throws -> T {
        guard let url = URL(string: endpoint, relativeTo: baseURL) else {
            throw NetworkError.invalidURL(endpoint)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
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
            throw NetworkError.decodingFailed(error.localizedDescription)
        }
    }
}
