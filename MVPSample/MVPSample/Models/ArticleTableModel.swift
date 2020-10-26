//
//  ArticleTableModel.swift
//  MVPSample
//
//  Created by Rei Matsushita on 2020/10/11.
//

import Foundation

protocol ArticleTableModelProtocol {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void)
}

class ArticleTableModel: ArticleTableModelProtocol {

    // MARK - Properties
    
    private let queryService: QueryService
    
    init(queryService: QueryService) {
        self.queryService = queryService
    }
    
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        queryService.getSearchResults(searchCompletion: completion)
    }
}
