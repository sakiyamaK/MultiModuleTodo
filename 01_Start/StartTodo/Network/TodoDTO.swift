import Foundation

struct TodoDTO: Codable, Sendable {
    let title: String
    let isCompleted: Bool
    let descriptionText: String
    
    var todo: Todo {
        Todo(title: self.title, isCompleted: self.isCompleted, descriptionText: self.descriptionText)
    }
}
