import Foundation
import SwiftData
import SwiftUI

// 外部モジュールからアクセスできるようにpublicにする
@Model
public final class Todo {
    // 外部モジュールからアクセスできるようにpublicにする
    public var title: String
    public var isCompleted: Bool
    public var descriptionText: String
    public var createdAt: Date

    // 外部モジュールからアクセスできるようにpublicにする
    public init(title: String, isCompleted: Bool = false, descriptionText: String = "") {
        self.title = title
        self.isCompleted = isCompleted
        self.descriptionText = descriptionText
        self.createdAt = Date()
    }
}
