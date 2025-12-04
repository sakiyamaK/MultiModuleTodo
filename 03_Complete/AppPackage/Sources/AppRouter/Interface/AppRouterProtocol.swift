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
    @Entry var router: AppRouterProtocol!
}

@MainActor
public protocol AppRouterProtocol {
    func toDetail(todo: Todo) -> AnyView
    func toList() -> AnyView
}
