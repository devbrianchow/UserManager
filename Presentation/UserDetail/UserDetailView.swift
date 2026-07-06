//
//  UserDetailView.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import SwiftUI

struct UserDetailView: View {
    @EnvironmentObject var router: NavigationRouter
    @StateObject var viewModel: UserDetailViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .foregroundColor(.blue)

                if viewModel.isEditing {
                    ValidatedTextField(
                        titleKey: LocalizedStringKey("field_name"),
                        text: $viewModel.editedName,
                        errorMessage: viewModel.nameError
                    )
                    ValidatedTextField(
                        titleKey: LocalizedStringKey("field_email"),
                        text: $viewModel.editedEmail,
                        errorMessage: viewModel.emailError,
                        keyboardType: .emailAddress
                    )

                } else {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        InfoRow(label: LocalizedStringKey("field_name"),   value: viewModel.user.name)
                        InfoRow(label: LocalizedStringKey("field_email"),    value: viewModel.user.email)
                        InfoRow(label: LocalizedStringKey("field_phone"), value: viewModel.user.phone)
                        InfoRow(label: LocalizedStringKey("field_web"),      value: viewModel.user.website)
                        InfoRow(label: LocalizedStringKey("field_city"),   value: viewModel.user.city)
                        InfoRow(label: LocalizedStringKey("field_company"),  value: viewModel.user.company.name)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red).font(.caption)
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.user.username)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if viewModel.isEditing {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(LocalizedStringKey("cancel")) { viewModel.cancelEditing() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(LocalizedStringKey("save")) { viewModel.saveChanges() }
                        .disabled(!viewModel.isFormValid)
                        .fontWeight(.semibold)
                }
            } else {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { viewModel.isEditing = true } label: {
                        Image(systemName: "pencil")
                    }
                }
            }
        }
        .toast(isPresented: $viewModel.isSaved, message: LocalizedStringKey("message_save"))
    }
}

// MARK: - InfoRow
private struct InfoRow: View {
    let label: LocalizedStringKey
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value.isEmpty ? "—" : value)
                .font(.body)
        }
    }
}

// MARK: - Toast
extension View {
    func toast(isPresented: Binding<Bool>, message: LocalizedStringKey) -> some View {
        modifier(ToastModifier(isPresented: isPresented, message: message))
    }
}

private struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: LocalizedStringKey

    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            if isPresented {
                Text(message)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.bottom, 32)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation { isPresented = false }
                        }
                    }
            }
        }
        .animation(.easeInOut, value: isPresented)
    }
}
