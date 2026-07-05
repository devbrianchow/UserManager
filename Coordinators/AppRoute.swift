//
//  AppRoute.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import Foundation

enum AppRoute: Hashable {
    case userDetail(user: User)
    case createUser
}
