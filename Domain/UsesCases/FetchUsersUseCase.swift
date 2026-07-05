//
//  FetchUsersUseCase.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation

protocol FetchUsersUseCaseProtocol {
    func execute() async throws -> [User]
}

final class FetchUsersUseCase: FetchUsersUseCaseProtocol {
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [User] {
        do {
            let remoteUsers = try await repository.fetchRemoteUsers()
            try repository.saveUsers(remoteUsers)
            let local = try repository.fetchLocalUsers()
            return local
        } catch {
            throw error
        }
    }
}
