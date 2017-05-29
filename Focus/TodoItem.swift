//
//  TodoItem.swift
//  Focus
//
//  Created by Pika Ma on 17/5/6.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import Foundation

struct TodoItem {
    var title: String
    var UUID: String
    var dateCreated: Date
    var isQuestion: Bool
    
    init(title: String, UUID: String, dateCreated: Date, isQuestion: Bool) {
        self.title = title
        self.UUID = UUID
        self.dateCreated = dateCreated
        self.isQuestion = isQuestion
    }
    
    mutating func replace(title: String, dateCreated: Date, isQuestion: Bool) {
        self.dateCreated = dateCreated
        self.title = title
        self.isQuestion = isQuestion
    }
    
    mutating func update(dateModified: Date) {
        self.dateCreated = dateModified
    }
    
    
}



