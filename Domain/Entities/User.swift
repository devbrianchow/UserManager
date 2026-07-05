//
//  User.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation

// MARK: - Domain Entities

struct User: Identifiable, Hashable {
    let id: Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    var address: Address
    var company: Company

    var city: String { address.city }
}

struct Address: Hashable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geo
}

struct Geo: Hashable {
    var lat: String
    var lng: String
}

struct Company: Hashable {
    var name: String
    var catchPhrase: String
    var bs: String
}
