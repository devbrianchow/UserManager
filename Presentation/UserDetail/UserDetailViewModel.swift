//
//  UserDetailViewModel.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation
import Combine

@MainActor
final class UserDetailViewModel: ObservableObject {

    @Published var user: User
    @Published var editedName: String
    @Published var editedEmail: String
    @Published var isEditing = false
    @Published var errorMessage: String?
    @Published var isSaved = false

    private let updateUserUseCase: UpdateUserUseCaseProtocol

    init(user: User, updateUser: UpdateUserUseCaseProtocol) {
        self.user = user
        self.editedName  = user.name
        self.editedEmail = user.email
        self.updateUserUseCase = updateUser
    }

    var nameError: String?  { editedName.isEmpty  ? nil : Validators.validName(editedName) }
    
    var emailError: String? { editedEmail.isEmpty ? nil : Validators.validEmail(editedEmail) }
    
    var isFormValid: Bool {
        Validators.validate([
            Validators.nonEmpty(editedName,  fieldName: NSLocalizedString("field_name",  comment: "")),
            Validators.nonEmpty(editedEmail, fieldName: NSLocalizedString("field_email", comment: "")),
            Validators.validName(editedName),
            Validators.validEmail(editedEmail)
        ]) == nil
    }
    
    func saveChanges() {
        errorMessage = nil
        do {
            try updateUserUseCase.execute(id: user.id, name: editedName, email: editedEmail)
            user.name  = editedName
            user.email = editedEmail
            isEditing  = false
            isSaved    = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func cancelEditing() {
        editedName  = user.name
        editedEmail = user.email
        isEditing   = false
    }
}
