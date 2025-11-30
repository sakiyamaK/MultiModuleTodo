//
//  ModelContainer.swift
//  AppPackages
//
//  Created by sakiyamaK on 2025/11/30.
//
import SwiftData

// 外部モジュールからアクセスできるようにpublicにする
public struct TodoModelContainer: Sendable {
    // 外部モジュールからアクセスできるようにpublicにする
    public static let shared = TodoModelContainer()

    private let config = ModelConfiguration(isStoredInMemoryOnly: true)
    // 外部モジュールからアクセスできるようにpublicにする
    public let container: ModelContainer

    private init() {
        container = try! ModelContainer(for: Todo.self, configurations: config)
    }
}
