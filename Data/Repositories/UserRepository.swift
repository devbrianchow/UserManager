//
//  UserRepository.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation

final class UserRepository: UserRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    private let realmService: RealmServiceProtocol

    init(
        apiService: APIServiceProtocol = APIService.shared,
        realmService: RealmServiceProtocol = RealmService.shared
    ) {
        self.apiService = apiService
        self.realmService = realmService
    }

    // MARK: - Remote
    
    func fetchRemoteUsers() async throws -> [User] {
        let dtos = try await apiService.fetchUsers()
        return dtos.map { $0.toDomain() }
    }

    func deleteRemoteUser(id: Int) async throws {
        try await apiService.deleteUser(id: id)
    }

    // MARK: - Local

    func fetchLocalUsers() throws -> [User] {
        try realmService.fetchActiveUsers().map { $0.toDomain() }
    }

    func saveUsers(_ users: [User]) throws {
        let objects = users.map { UserRealmObject.from(domain: $0) }
        try realmService.saveUsers(objects)
    }

    func saveUser(_ user: User, isLocal: Bool = false) throws {
        let object = UserRealmObject.from(domain: user, isLocal: isLocal)
        try realmService.saveUser(object)
    }

    func updateUser(id: Int, name: String, email: String) throws {
        try realmService.updateUser(id: id, name: name, email: email)
    }

    func softDeleteUser(id: Int) throws {
        try realmService.softDeleteUser(id: id)
    }
}
