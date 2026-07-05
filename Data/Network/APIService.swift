//
//  APIService.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation
@preconcurrency import Alamofire

// MARK: - APIError

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case networkError(AFError)
    case serverError(Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid server response."
        case .networkError(let error):
            return error.localizedDescription
        case .serverError(let code):
            return "Server error: \(code)."
        }
    }
}

// MARK: - Protocol

protocol APIServiceProtocol {
    func fetchUsers() async throws -> [UserDTO]
    func deleteUser(id: Int) async throws
}

// MARK: - Implementation

final class APIService: APIServiceProtocol {

    static let shared = APIService()

    private let baseURL = "http://jsonplaceholder.typicode.com" // Use http for test in simulator
    private let session = Session()

    private init() {}

    // MARK: - Fetch Users

    /// Use URLSession in this case because  I had problems calling responseDecodable from alamofire
    func fetchUsers() async throws -> [UserDTO] {
        guard let url = URL(string: "\(baseURL)/users") else {
            throw APIError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([UserDTO].self, from: data)
    }
    
    // MARK: - Delete User

    func deleteUser(id: Int) async throws {
        guard let url = URL(string: "\(baseURL)/users/\(id)") else {
            throw APIError.invalidURL
        }

        try await withCheckedThrowingContinuation { continuation in
            session
                .request(url, method: .delete)
                .validate()
                .response { response in
                    switch response.result {
                    case .success:
                        continuation.resume()
                    case .failure(let error):
                        continuation.resume(throwing: APIError.networkError(error))
                    }
                }
        }
    }
}
