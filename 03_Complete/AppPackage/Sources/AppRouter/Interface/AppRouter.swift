//
//  AppRouter.swift
//  AppPackages
//
//  Created by sakiyamaK on 2025/11/30.
//

import Foundation
import Model
import SwiftUI

public extension EnvironmentValues {
    @Entry var router: AppRouter!
}

@MainActor
public protocol AppRouter {
    func toDetail(todo: Todo) -> AnyView
    func toList() -> AnyView
}
