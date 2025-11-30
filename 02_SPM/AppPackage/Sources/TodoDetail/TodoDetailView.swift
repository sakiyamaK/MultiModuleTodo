import SwiftUI
// 別モジュールをimportする
import Model

// 外部モジュールからアクセスできるようにpublicにする
public struct TodoDetailView: View {
    @Bindable var todo: Todo

    // 外部モジュールからインスタンスを生成できるようにpublicにする
    public init(todo: Todo) {
        self.todo = todo
    }
    
    // struct自体がpublicになったのでbodyもpublicにする
    public var body: some View {
        Form {
            Section(header: Text("Info")) {
                TextField("Title", text: $todo.title)
                Toggle("Completed", isOn: $todo.isCompleted)
            }

            Section(header: Text("Description")) {
                TextEditor(text: $todo.descriptionText)
                    .frame(minHeight: 100)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        let todo = Todo(
            title: "Sample Todo",
            isCompleted: true,
            descriptionText: "Sample Description"
        )
        TodoDetailView(todo: todo)
    }
}
