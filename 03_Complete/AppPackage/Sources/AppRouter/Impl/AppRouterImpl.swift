import SwiftUI
import SwiftData
import Model
import TodoDetail
import TodoList
import AppRouterInterface
import Network

@MainActor
public final class AppRouterImpl: AppRouter {

    public static let shared = AppRouterImpl()

    private init() { }

    @ViewBuilder
    public func toDetail(todo: Todo) -> AnyView {
        AnyView(
            TodoDetailView(todo: todo)
                .modelContainer(TodoModelContainer.shared.container)
        )
    }

    @ViewBuilder
    public func toList() -> AnyView {
        AnyView(
            NavigationStack {
                TodoListView(client: TodoClientImpl())
                    .modelContainer(TodoModelContainer.shared.container)
            }
        )
    }
}
