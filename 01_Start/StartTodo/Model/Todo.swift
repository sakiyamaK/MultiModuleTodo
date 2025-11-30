import Foundation
import SwiftData
import SwiftUI

@Model
final class Todo {
    var title: String
    var isCompleted: Bool
    var descriptionText: String
    var createdAt: Date

    init(title: String, isCompleted: Bool = false, descriptionText: String = "") {
        self.title = title
        self.isCompleted = isCompleted
        self.descriptionText = descriptionText
        self.createdAt = Date()
    }
}
