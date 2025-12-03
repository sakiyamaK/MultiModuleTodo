import SwiftUI
// 別モジュールをimportする
import Model

/*
 TodoDetailViewをpublicにしていくのがめんどくさいなら
 外部モジュールと連携専用の何かを用意してやるといい
 ただ外部モジュールからはsome ViewであってTodoDetailViewなことは分からなくなる
 */
public enum TodoDetailViewBuilder {
    @MainActor
    @ViewBuilder
    public static func build(todo: Todo) -> some View {
        TodoDetailView(todo: todo)
    }
}

struct TodoDetailView: View {
    @Bindable var todo: Todo

    var body: some View {
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
