import Foundation
import Model

public struct TodoDTO: Codable, Sendable {
    public let title: String
    public let isCompleted: Bool
    public let descriptionText: String
    
    public init(title: String, isCompleted: Bool, descriptionText: String) {
        self.title = title
        self.isCompleted = isCompleted
        self.descriptionText = descriptionText
    }

    public var todo: Todo {
        Todo(title: self.title, isCompleted: self.isCompleted, descriptionText: self.descriptionText)
    }

//    public var todo: Todo {
//        Todo(
//            title: LocalizedText(
//                japanese: self.title,
//                english: self.title
//            ),
//            isCompleted: self.isCompleted,
//            descriptionText: self.descriptionText
//        )
//    }
}
