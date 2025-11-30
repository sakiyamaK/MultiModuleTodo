//
//  ModelContainer.swift
//  AppPackages
//
//  Created by sakiyamaK on 2025/11/30.
//
import SwiftData

struct TodoModelContainer: Sendable {
    static let shared = TodoModelContainer()

    private let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container: ModelContainer

    private init() {
        container = try! ModelContainer(for: Todo.self, configurations: config)
    }
}
