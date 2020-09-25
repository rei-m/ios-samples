//
//  TodoMock.swift
//  TodoApp
//
//  Created by Rei Matsushita on 2020/09/22.
//  Copyright © 2020 Rei Matsushita. All rights reserved.
//

import Foundation

class TodoMock {
    // MARK: Properties
    let title: String
    let content: String
    let isChecked: Bool
    let createdAt: Date
    
    // MARK: Initialization
    init?(title: String, content: String, createdAt: Date = Date()) {
        guard !title.isEmpty || !content.isEmpty else {
            return nil
        }
        self.title = title
        self.content = content
        self.isChecked = false
        self.createdAt = createdAt
    }
}
