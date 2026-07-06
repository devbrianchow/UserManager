//
//  UserListViewModel.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation
import Combine

@MainActor
final class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let fetchUsers: FetchUsersUseCaseProtocol
    private let saveUser: SaveUserUseCaseProtocol
    
    init(
        fetchUsers: FetchUsersUseCaseProtocol,
        saveUser: SaveUserUseCaseProtocol
    ) {
        self.fetchUsers = fetchUsers
        self.saveUser = saveUser
    }

    func loadUsers() async {
        isLoading = true
        errorMessage = nil
        do {
            users = try await fetchUsers.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func add(user: User) {
        do {
            try saveUser.execute(user: user)
            users.insert(user, at: 0)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
