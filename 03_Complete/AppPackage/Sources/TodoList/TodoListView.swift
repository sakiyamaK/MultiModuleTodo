import SwiftUI
import SwiftData
import Model
import Network
import AppRouterInterface

public struct TodoListView: View {
    private var client: TodoClient
    @Environment(\.router) private var router
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Todo.createdAt, order: .reverse) private var todos: [Todo]
    @State private var hasLoaded = false

    public init(client: TodoClient) {
        self.client = client
    }

    public var body: some View {
        List {
            ForEach(todos) { todo in
                NavigationLink {
                    router?.toDetail(todo: todo)
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
    TodoListView(client: TodoClientImpl())
        .modelContainer(TodoModelContainer.shared.container)
}
