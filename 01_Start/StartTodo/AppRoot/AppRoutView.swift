//
//  AppRoutView.swift
//  StartTodo
//
//  Created by sakiyamaK on 2025/11/30.
//

import SwiftUI
import SwiftData

struct AppRootView: View {

    var body: some View {
        NavigationStack {
            TodoListView(client: TodoClient())
                .modelContainer(TodoModelContainer.shared.container)
        }
    }
}

#Preview {
    AppRootView()
}
