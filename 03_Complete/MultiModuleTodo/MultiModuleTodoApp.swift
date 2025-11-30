//
//  MultiModuleTodoApp.swift
//  MultiModuleTodo
//
//  Created by sakiyamaK on 2025/11/30.
//

import SwiftUI
import SwiftData
import AppRoot
import Model
import AppRouterInterface
import AppRouterImpl

@main
struct MultiModuleTodoApp: App {
    var body: some Scene {
        WindowGroup {
            AppRootView()
        }
        .environment(\.router, AppRouterImpl.shared)
    }
}
