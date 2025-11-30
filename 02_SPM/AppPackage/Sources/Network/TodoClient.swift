import Foundation
import SwiftData
// 別モジュールをimportする
import Model

// 外部モジュールからアクセスできるようにpublicにする
public protocol TodoClient: Sendable {
    func fetchTodos() async throws
}

// 外部モジュールからアクセスできるようにpublicにする
public struct TodoClientImpl: TodoClient {

    // 外部モジュールからインスタンスを生成できるようにpublicにする
    public init() { }

    // 外部モジュールからアクセスできるようにpublicにする
    public func fetchTodos() async throws {
        // Simulate network delay
        try await Task.sleep(for: .seconds(0.5))
        // Bundle.mainからBundle.moduleに変える
        guard let url = Bundle.module.url(forResource: "mock_todos", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        
        let data = try Data(contentsOf: url)
        let dotoDTOs = try JSONDecoder().decode([TodoDTO].self, from: data)

        Task { @MainActor in
            for todo in dotoDTOs.map(\.todo) {
                TodoModelContainer.shared.container.mainContext.insert(todo)
            }
        }
    }
}
