//
//  UserDTO.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation

// MARK: - UserDTO

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: AddressDTO
    let company: CompanyDTO
}

// MARK: - AddressDTO

struct AddressDTO: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: GeoDTO
}

// MARK: - GeoDTO

struct GeoDTO: Decodable {
    let lat: String
    let lng: String
}

// MARK: - CompanyDTO

struct CompanyDTO: Decodable {
    let name: String
    let catchPhrase: String
    let bs: String
}

// MARK: - Mappers DTO to Domain
extension UserDTO {
    func toDomain() -> User {
        User(
            id: id,
            name: name,
            username: username,
            email: email,
            phone: phone,
            website: website,
            address: address.toDomain(),
            company: company.toDomain()
        )
    }
}

extension AddressDTO {
    func toDomain() -> Address {
        Address(
            street: street,
            suite: suite,
            city: city,
            zipcode: zipcode,
            geo: geo.toDomain()
        )
    }
}

extension GeoDTO {
    func toDomain() -> Geo {
        Geo(lat: lat, lng: lng)
    }
}

extension CompanyDTO {
    func toDomain() -> Company {
        Company(
            name: name,
            catchPhrase: catchPhrase,
            bs: bs
        )
    }
}
