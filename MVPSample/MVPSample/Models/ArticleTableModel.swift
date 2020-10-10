//
//  ArticleTableModel.swift
//  MVPSample
//
//  Created by Rei Matsushita on 2020/10/11.
//

import Foundation

class ArticleTableModel {

    // MARK - Properties
    
    private let queryService: QueryService
    
    init(queryService: QueryService) {
        self.queryService = queryService
    }
    
    func fetchArticles(completion: @escaping ([Article]?, String) -> Void) {
        queryService.getSearchResults(searchCompletion: completion)
    }
}
