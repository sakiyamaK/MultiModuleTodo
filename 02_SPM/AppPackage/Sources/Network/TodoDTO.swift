import Foundation
// 別モジュールをimportする
import Model

// 外部モジュールからアクセスできるようにpublicにする
public struct TodoDTO: Codable, Sendable {
    let title: String
    let isCompleted: Bool
    let descriptionText: String

    // 外部モジュールからインスタンスを生成できるようにpublicにする
    public init(title: String, isCompleted: Bool, descriptionText: String) {
        self.title = title
        self.isCompleted = isCompleted
        self.descriptionText = descriptionText
    }

    // 外部モジュールからアクセスできるようにpublicにする
    public var todo: Todo {
        Todo(title: self.title, isCompleted: self.isCompleted, descriptionText: self.descriptionText)
    }
}
