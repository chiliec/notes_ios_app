//
//  Note.swift
//  Notes
//
//  Created by Бабин Владимир on 27/06/2019.
//  Copyright © 2019 Pro IT Resource. All rights reserved.
//

import UIKit

enum Importance: String {
    case unimportant, ordinary, important
}

struct Note: Equatable {
    let uid: String
    let title: String
    let content: String
    let color: UIColor
    let importance: Importance
    let selfDestructionDate: Date?

    init(uid: String = UUID().uuidString, title: String, content: String,
         color: UIColor = .white, importance: Importance = .ordinary,
         selfDestructionDate: Date? = nil) {
        self.uid = uid
        self.title = title
        self.content = content
        self.color = color
        self.importance = importance
        self.selfDestructionDate = selfDestructionDate
    }
}
