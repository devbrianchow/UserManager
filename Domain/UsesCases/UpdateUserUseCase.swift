//
//  UpdateUserUseCase.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation

protocol UpdateUserUseCaseProtocol {
    func execute(id: Int, name: String, email: String) throws
}

final class UpdateUserUseCase: UpdateUserUseCaseProtocol {
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: Int, name: String, email: String) throws {
        try repository.updateUser(id: id, name: name, email: email)
    }
}
