import SwiftUI
import SwiftData
import AppRouterInterface
import Model
import Network

public struct AppRootView: View {

    @Environment(\.router) private var router: AppRouterProtocol

    public init() { }

    public var body: some View {
        router.toList()
    }
}

#if DEBUG
final class TestRouterImpl: AppRouterProtocol {
    func toDetail(todo: Model.Todo) -> AnyView {
        AnyView(Text("Detail"))
    }

    func toList() -> AnyView {
        AnyView(Text("List"))
    }
}

#Preview {
    AppRootView()
        .environment(\.router, TestRouterImpl())
}
#endif
