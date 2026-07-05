//
//  UserRepositoryProtocol.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchRemoteUsers() async throws -> [User]
    func fetchLocalUsers() throws -> [User]
    func saveUsers(_ users: [User]) throws
    func saveUser(_ user: User, isLocal: Bool) throws
    func updateUser(id: Int, name: String, email: String) throws
    func softDeleteUser(id: Int) throws
    func deleteRemoteUser(id: Int) async throws
}
