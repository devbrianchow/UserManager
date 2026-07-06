//
//  AppCoordinatorView.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import SwiftUI

struct AppCoordinatorView: View {
    @EnvironmentObject var router: NavigationRouter

    @StateObject private var listViewModel: UserListViewModel = {
        let repo = UserRepository()
        return UserListViewModel(
            fetchUsers: FetchUsersUseCase(repository: repo),
            saveUser:   SaveUserUseCase(repository: repo),
            deleteUser: DeleteUserUseCase(repository: repo)
        )
    }()

    @StateObject private var createViewModel = CreateUserViewModel()

    var body: some View {
        NavigationStack(path: $router.path) {

            UserListView(viewModel: listViewModel)
                .environmentObject(router)

                .navigationDestination(for: AppRoute.self) { route in
                    switch route {

                    case .userDetail(let user):
                        let repo = UserRepository()
                        UserDetailView(
                            viewModel: UserDetailViewModel(
                                user: user,
                                updateUser: UpdateUserUseCase(repository: repo)
                            )
                        )
                        .environmentObject(router)

                    case .createUser:
                        CreateUserView(
                            viewModel: createViewModel,
                            onUserCreated: { newUser in
                                listViewModel.add(user: newUser)
                            }
                        )
                        .environmentObject(router)
                    }
                }
        }
    }
}
