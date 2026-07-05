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
            fetchUsers: FetchUsersUseCase(repository: repo)
        )
    }()

    var body: some View {
        NavigationStack(path: $router.path) {

            UserListView(viewModel: listViewModel)

                .navigationDestination(for: AppRoute.self) { route in
                    switch route {

                    case .userDetail(let user):
                        Text("Example View User Detail")
                            .font(.title)
                            .padding()

                    case .createUser:
                        Text("Example View Create User")
                            .font(.title)
                            .padding()
                    }
                }
        }
    }
}
