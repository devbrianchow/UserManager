//
//  UserListView.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: UserListViewModel

    var body: some View {
        List {
            ForEach(viewModel.users) { user in
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)

                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text(user.email)
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
        .navigationTitle("Usuarios")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //TODO: Add delete user
                } label: {
                    Image(systemName: "person.badge.plus")
                }
            }
        }
        .task {
            await viewModel.loadUsers()
        }
    }
}
