//
//  DeleteUserUseCase.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation

protocol DeleteUserUseCaseProtocol {
    func execute(id: Int) throws
}

final class DeleteUserUseCase: DeleteUserUseCaseProtocol {
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: Int) throws {
        try repository.softDeleteUser(id: id)
    }
}
