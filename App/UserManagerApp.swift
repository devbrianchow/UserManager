//
//  UserManagerApp.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import SwiftUI

@main
struct UserManagerApp: App {
    @StateObject private var router = NavigationRouter()

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView()
                .environmentObject(router)
        }
    }
}
