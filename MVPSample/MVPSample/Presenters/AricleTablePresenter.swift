//
//  AricleTablePresenter.swift
//  MVPSample
//
//  Created by Rei Matsushita on 2020/10/26.
//

import Foundation

protocol ArticleTablePresenterProtocol: AnyObject {
    func viewDidLoad()
}

class ArticleTablePresenter: ArticleTablePresenterProtocol {
    
    private weak var view: ArticleTableViewProtocol!
    private let model: ArticleTableModelProtocol
    
    init(view: ArticleTableViewProtocol, model: ArticleTableModelProtocol) {
        self.view = view
        self.model = model
    }
    
    func viewDidLoad() {
        view.updateLoading(true)

        model.fetchArticles() { [weak self] result in
            self?.view.updateLoading(false)
            switch result {
            case .success(let articles):
                self?.view.updateArticleTable(articles)
            case .failure(let error):
                print(error)
            }
        }
    }
}
