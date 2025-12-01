import SwiftUI
import SwiftData

struct TodoListView: View {
    let client: TodoClientProtocol
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Todo.createdAt, order: .reverse) private var todos: [Todo]
    @State private var hasLoaded = false

    var body: some View {
        List {
            ForEach(todos) { todo in
                NavigationLink {
                    TodoDetailView(todo: todo)
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
        TodoListView(client: TodoClient())
            .modelContainer(TodoModelContainer.shared.container)
    }
}
