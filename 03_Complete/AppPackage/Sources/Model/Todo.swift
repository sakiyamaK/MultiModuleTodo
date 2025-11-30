import Foundation
import SwiftData
import SwiftUI

@Model
public final class Todo {
    public var title: String
    //    public var title: LocalizedText
    public var isCompleted: Bool
    public var descriptionText: String
    public var createdAt: Date

    public init(title: String, isCompleted: Bool = false, descriptionText: String = "") {
        self.title = title
        self.isCompleted = isCompleted
        self.descriptionText = descriptionText
        self.createdAt = Date()
    }

//    public init(title: LocalizedText, isCompleted: Bool = false, descriptionText: String = "") {
//        self.title = title
//        self.isCompleted = isCompleted
//        self.descriptionText = descriptionText
//        self.createdAt = Date()
//    }
//
//    public convenience init(title: String, isCompleted: Bool = false, descriptionText: String = "") {
//        self.init(
//            title: .init(japanese: title, english: title),
//            isCompleted: isCompleted,
//            descriptionText: descriptionText
//        )
//    }
}
