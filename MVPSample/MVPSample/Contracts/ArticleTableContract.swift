//
//  ArticleView.swift
//  MVPSample
//
//  Created by Rei Matsushita on 2020/10/11.
//

import Foundation

protocol ArticleTableContractView {
    func updateArticles(_ articles: [Article] )
    func updateLoading(_ isLoading: Bool)
}

protocol ArticleTableContractPresenter {
    func viewDidLoad()
}
