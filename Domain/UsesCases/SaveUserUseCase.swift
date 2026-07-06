//
//  SaveUserUseCase.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation

protocol SaveUserUseCaseProtocol {
    func execute(user: User) throws
}

final class SaveUserUseCase: SaveUserUseCaseProtocol {
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func execute(user: User) throws {
        try repository.saveUser(user, isLocal: true)
    }
}
