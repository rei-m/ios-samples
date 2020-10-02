//
//  ArticleTableViewController.swift
//  UrlSessionSample
//
//  Created by Rei Matsushita on 2020/10/02.
//  Copyright © 2020 Rei Matsushita. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    //
    // MARK: - Constants
    //
    let queryService = QueryService()
    
//    private let articles = [
//        Article(title: "title1", body: "body1", createdAt: Date()),
//        Article(title: "title2", body: "body2", createdAt: Date()),
//        Article(title: "title3", body: "body3", createdAt: Date()),
//        Article(title: "title4", body: "body4", createdAt: Date())
//    ]

    private var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        // TODO: 調べる
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        queryService.getSearchResults() { [weak self] results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false

            if let results = results {
                self?.articles = results
                self?.tableView.reloadData()
                self?.tableView.setContentOffset(CGPoint.zero, animated: false)
            }

            if !errorMessage.isEmpty {
                print("Search error: \(errorMessage)")
            }
        }
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
