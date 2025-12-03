import SwiftUI
import SwiftData
// 別モジュールをimportする
import Model
import TodoDetail
import Network

// 外部モジュールからアクセスできるようにpublicにする
public struct TodoListView: View {
    private let client: TodoClient
    // 外部モジュールからインスタンスを生成できるようにpublicにする
    public init(client: TodoClient) {
        self.client = client
    }
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Todo.createdAt, order: .reverse) private var todos: [Todo]
    @State private var hasLoaded = false

    // struct自体がpublicになったのでbodyもpublicにする
    public var body: some View {
        List {
            ForEach(todos) { todo in
                NavigationLink {
                    /* *******
                     TodoDetailViewのモジュールに依存している！！
                     もしTodoDetailViewのモジュールからさらにAViewのモジュール -> BViewのモジュール -> CViewのモジュール
                     と遷移が続いたら結局全部のViewに依存するのでモジュールが分離できていない
                     ******* */
                    TodoDetailViewBuilder.build(todo: todo)
                } label: {
                    HStack {
                        Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(todo.isCompleted ? .green : .gray)
                            .onTapGesture {
                                todo.isCompleted.toggle()
                            }
                        Text(todo.title)
                            .strikethrough(todo.isCompleted)
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .task {
            guard !hasLoaded else { return }
            hasLoaded = true
            try! await client.fetchTodos()
        }
    }
}

private extension TodoListView {
    func addItem() {
        withAnimation {
            let newTodo = Todo(title: "New Todo", descriptionText: "Description")
            modelContext.insert(newTodo)
        }
    }

    func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(todos[index])
            }
        }
    }
}

#Preview {
    NavigationStack {
        TodoListView(client: TodoClientImpl())
            .modelContainer(TodoModelContainer.shared.container)
    }
}
