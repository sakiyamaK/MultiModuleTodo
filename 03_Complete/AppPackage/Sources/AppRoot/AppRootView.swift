import SwiftUI
import SwiftData
import AppRouterInterface
import Model
import Network

public struct AppRootView: View {

    @Environment(\.router) private var router: AppRouter

    public init() { }

    public var body: some View {
        router.toList()
    }
}

import AppRouterImpl

#Preview {
    AppRootView()
        .environment(\.router, AppRouterImpl.shared)
}
