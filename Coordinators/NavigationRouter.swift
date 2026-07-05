//
//  NavigationRouter.swift
//  UserManager
//
//  Created by Brian Huamani on 5/07/26.
//

import SwiftUI
import Combine

final class NavigationRouter: ObservableObject {

    @Published var path = NavigationPath()

    // MARK: - Methods for navigation

    func navigate(to route: AppRoute) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
