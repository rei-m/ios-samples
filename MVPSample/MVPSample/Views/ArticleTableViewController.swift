//
//  ViewController.swift
//  MVPSample
//
//  Created by Rei Matsushita on 2020/10/11.
//

import UIKit

protocol ArticleTableViewProtocol {
    func updateLoading(_ isLoading: Bool)
    func updateArticleTable(_ articles: [Article])
}

class ArticleTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//
//            if let results = results {
//                self?.articles = results
//                self?.tableView.reloadData()
//                self?.tableView.setContentOffset(CGPoint.zero, animated: false)
//            }
//
//            if !errorMessage.isEmpty {
//                print("Search error: \(errorMessage)")
//            }
