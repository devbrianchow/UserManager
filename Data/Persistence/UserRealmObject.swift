//
//  UserRealmObject.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation
import RealmSwift

// MARK: - UserRealmObject

final class UserRealmObject: Object {

    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var username: String = ""
    @Persisted var email: String = ""
    @Persisted var phone: String = ""
    @Persisted var website: String = ""

    // MARK: Address
    @Persisted var street: String = ""
    @Persisted var suite: String = ""
    @Persisted var city: String = ""
    @Persisted var zipcode: String = ""
    @Persisted var geoLat: String = ""
    @Persisted var geoLng: String = ""

    // MARK: Company
    @Persisted var companyName: String = ""
    @Persisted var companyCatchPhrase: String = ""
    @Persisted var companyBs: String = ""

    // MARK: Flags
    @Persisted var isDeleted: Bool = false
    @Persisted var isLocal: Bool = false
}

// MARK: - Domain Mapping

extension UserRealmObject {
    
    func toDomain() -> User {
        User(
            id: id,
            name: name,
            username: username,
            email: email,
            phone: phone,
            website: website,
            address: Address(
                street: street,
                suite: suite,
                city: city,
                zipcode: zipcode,
                geo: Geo(lat: geoLat, lng: geoLng)
            ),
            company: Company(
                name: companyName,
                catchPhrase: companyCatchPhrase,
                bs: companyBs
            )
        )
    }
    
    static func from(domain user: User, isLocal: Bool = false) -> UserRealmObject {
        let object = UserRealmObject()
        object.id = user.id
        object.name = user.name
        object.username = user.username
        object.email = user.email
        object.phone = user.phone
        object.website = user.website
        object.isLocal = isLocal

        object.street = user.address.street
        object.suite = user.address.suite
        object.city = user.address.city
        object.zipcode = user.address.zipcode
        object.geoLat = user.address.geo.lat
        object.geoLng = user.address.geo.lng

        object.companyName = user.company.name
        object.companyCatchPhrase = user.company.catchPhrase
        object.companyBs = user.company.bs

        return object
    }
}
