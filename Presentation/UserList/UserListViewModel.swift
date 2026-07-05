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
    
    init(
        fetchUsers: FetchUsersUseCaseProtocol
    ) {
        self.fetchUsers = fetchUsers
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
}
