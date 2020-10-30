//
//  ViewController.swift
//  MVPSample
//
//  Created by Rei Matsushita on 2020/10/11.
//

import UIKit

protocol ArticleTableViewProtocol: AnyObject {
    func updateLoading(_ isLoading: Bool)
    func updateArticleTable(_ articles: [Article])
    func displayError(_ message: String)
}

class ArticleTableViewController: UITableViewController, ArticleTableViewProtocol {

    private var presenter: ArticleTablePresenterProtocol!

    private let model = ArticleTableModel(queryService: QueryService())
    
    private var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        presenter = ArticleTablePresenter(view: self, model: model)
        presenter.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("The dequeued cell is not instance of ArticleTableViewCell.")
        }
        
        cell.titleLabel.text = articles[indexPath.item].title

        return cell
    }

    // MARK: - View methods
    func updateLoading(_ isLoading: Bool) {
        // deprecatedになった
        // UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
    }
    
    func updateArticleTable(_ articles: [Article]) {
        self.articles = articles
        self.tableView.reloadData()
        self.tableView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func displayError(_ message: String) {
        print("Error: \(message)")
    }
}
