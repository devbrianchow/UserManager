//
//  CreateUserViewModel.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation
import Combine

@MainActor
final class CreateUserViewModel: ObservableObject {

    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var showLocationPopup: Bool = false
    @Published var latitude: Double?
    @Published var longitude: Double?
    @Published var locationError: String?

    var nameError: String?  { name.isEmpty  ? nil : Validators.validName(name)   }
    var emailError: String? { email.isEmpty ? nil : Validators.validEmail(email) }
    var phoneError: String? { phone.isEmpty ? nil : Validators.validPhone(phone) }

    var isFormValid: Bool {
        Validators.validate([
            Validators.nonEmpty(name,  fieldName: NSLocalizedString("field_name",  comment: "")),
            Validators.nonEmpty(email, fieldName: NSLocalizedString("field_email", comment: "")),
            Validators.nonEmpty(phone, fieldName: NSLocalizedString("field_phone", comment: "")),
            Validators.validName(name),
            Validators.validEmail(email),
            Validators.validPhone(phone)
        ]) == nil
    }

    private let locationService: LocationService

    init(locationService: LocationService = LocationService.shared) {
        self.locationService = locationService
    }

    func requestLocation() {
        locationError = nil
        locationService.onLocationUpdate = { [weak self] lat, lng in
            Task { @MainActor in
                self?.latitude = lat
                self?.longitude = lng
                self?.showLocationPopup = true
            }
        }
        locationService.requestSingleLocation()
        if let error = locationService.locationError {
            locationError = error
        }
    }

    func buildUser() -> User {
        User(
            id: .random(in: 1000...9999),
            name: name,
            username: name.lowercased().replacingOccurrences(of: " ", with: "."),
            email: email,
            phone: phone,
            website: "",
            address: Address(
                street: "", suite: "", city: "", zipcode: "",
                geo: Geo(
                    lat: latitude.map  { String($0) } ?? "",
                    lng: longitude.map { String($0) } ?? ""
                )
            ),
            company: Company(name: "", catchPhrase: "", bs: "")
        )
    }
}
