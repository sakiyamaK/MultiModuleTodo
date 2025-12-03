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

    /*
     AnyViewにしないとダメ？
     SwiftUIを実務で使ってないから他に良いやり方があるのか分からない...
     */
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
