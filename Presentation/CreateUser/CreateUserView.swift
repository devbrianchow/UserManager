//
//  CreateUserView.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import SwiftUI

struct CreateUserView: View {
    @EnvironmentObject var router: NavigationRouter
    @ObservedObject var viewModel: CreateUserViewModel
    var onUserCreated: ((User) -> Void)?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    ValidatedTextField(titleKey: LocalizedStringKey("field_name"), text: $viewModel.name, errorMessage: viewModel.nameError)
                    ValidatedTextField(titleKey: LocalizedStringKey("field_email"), text: $viewModel.email, errorMessage: viewModel.emailError, keyboardType: .emailAddress)
                    ValidatedTextField(titleKey: LocalizedStringKey("field_phone"), text: $viewModel.phone, errorMessage: viewModel.phoneError, keyboardType: .phonePad)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Button(LocalizedStringKey("get_location")) {
                        viewModel.requestLocation()
                    }

                    if let error = viewModel.locationError {
                        Text(error).font(.caption).foregroundColor(.red)
                    }

                    if let lat = viewModel.latitude, let lng = viewModel.longitude {
                        Text(String(format: "%.5f, %.5f", lat, lng))
                            .font(.caption.monospacedDigit())
                            .foregroundColor(.secondary)
                    }
                }

                Button(LocalizedStringKey("create_user")) {
                    onUserCreated?(viewModel.buildUser())
                    router.pop()
                }
                .buttonStyle(.borderedProminent)
                .disabled(!viewModel.isFormValid)
            }
            .padding()
        }
        .navigationTitle(LocalizedStringKey("nav_create_user"))
        .navigationBarTitleDisplayMode(.inline)
        .alert(LocalizedStringKey("location_popup_title"), isPresented: $viewModel.showLocationPopup) {
            Button(LocalizedStringKey("ok")) { viewModel.showLocationPopup = false }
        } message: {
            if let lat = viewModel.latitude, let lng = viewModel.longitude {
                Text("\(lat), \(lng)")
            }
        }
    }
}
