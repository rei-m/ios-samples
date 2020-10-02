//
//  Article.swift
//  UrlSessionSample
//
//  Created by Rei Matsushita on 2020/10/02.
//  Copyright © 2020 Rei Matsushita. All rights reserved.
//

import Foundation

//
// MARK: - Article
//

/// Article of Qiita
class Article {
    //
    // MARK: - Constants
    //
    let title: String
    let body: String
    let createdAt: Date
    
    init(title: String, body: String, createdAt: Date) {
        self.title = title
        self.body = body
        self.createdAt = createdAt
    }
}
