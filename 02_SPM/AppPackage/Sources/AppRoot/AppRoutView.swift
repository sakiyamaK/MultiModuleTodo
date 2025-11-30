//
//  AppRoutView.swift
//  StartTodo
//
//  Created by sakiyamaK on 2025/11/30.
//

import SwiftUI
import SwiftData
// 別モジュールをimportする
import TodoList
import Network
import Model

// 外部モジュールからアクセスできるようにpublicにする
public struct AppRootView: View {
    // 外部モジュールからインスタンスを生成できるようにpublicにする
    public init() { }

    // struct自体がpublicになったのでbodyもpublicにする
    public var body: some View {
        NavigationStack {
            TodoListView(client: TodoClientImpl())
                .modelContainer(TodoModelContainer.shared.container)
        }
    }
}

#Preview {
    AppRootView()
}
