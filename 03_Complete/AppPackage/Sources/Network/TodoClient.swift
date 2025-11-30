import Foundation
import SwiftData
import Model

public protocol TodoClient: Sendable {
    func fetchTodos() async throws
}

public struct TodoClientImpl: TodoClient {

    public init() { }

    public func fetchTodos() async throws {
        // Simulate network delay
        try await Task.sleep(for: .seconds(0.5))
        
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
