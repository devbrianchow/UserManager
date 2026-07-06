//
//  UserListView.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import SwiftUI

struct UserListView: View {
    @EnvironmentObject var router: NavigationRouter
    @ObservedObject var viewModel: UserListViewModel

    var body: some View {
        List {
            ForEach(viewModel.users) { user in
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)

                    VStack(alignment: .leading) {
                        Text(user.username)
                            .font(.headline)
                        Text(user.name)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(user.phone)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(user.city)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    Button {} label: {
                        Image(systemName: "pencil")
                            .foregroundColor(.orange)
                    }
                    .buttonStyle(.plain)
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                         //TODO: Call delete user
                    } label: {
                        Label("Eliminar", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle(LocalizedStringKey("nav_list_user"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    router.navigate(to: .createUser)
                } label: {
                    Image(systemName: "person.badge.plus")
                        .font(.system(size: 24))
                }
            }
        }
        .task {
            await viewModel.loadUsers()
        }
    }
}
