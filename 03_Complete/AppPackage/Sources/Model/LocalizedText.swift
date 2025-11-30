//
//  LocalizedText.swift
//  AppPackages
//
//  Created by sakiyamaK on 2025/11/30.
//

public struct LocalizedText: Codable, Hashable, Sendable {
    public var japanese: String
    public var english: String

    public init(japanese: String, english: String) {
        self.japanese = japanese
        self.english = english
    }
}

