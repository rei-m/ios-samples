//
//  TodoTableViewController.swift
//  TodoApp
//
//  Created by Rei Matsushita on 2020/09/22.
//  Copyright © 2020 Rei Matsushita. All rights reserved.
//

import UIKit
import os.log

class TodoTableViewController: UITableViewController {

    private var mockData: [TodoMock] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    // セクションの数
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // セクションに対する行数を決めるデリゲートメソッド
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mockData.count
    }

    // 表示するCellのViewを返すデリゲートメソッド
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoTableViewCell else {
            fatalError("The dequeued cell is not instance of TodoTableViewCell.")
        }

        let todo = mockData[indexPath.row]
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy年MM月dd日 HH時mm分"
        
        cell.titleLabel.text = todo.title
        cell.dateLabel.text = formatter.string(from: todo.createdAt)
        
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

    // MARK: - Action
    // 先にIBActionを定義してからStoryboardでExitにSequeを関連付ける
    @IBAction func unwindToTodoList(sender: UIStoryboardSegue) {
        // sender.source: 遷移元のViewController
        // sender.destination: 遷移先のViewController
        guard let sourceViewController = sender.source as? TodoDetailViewController, let todo = sourceViewController.todo else {
            return
        }

        // indexPathForSelectedRowで行を選択していた場合はそこのindexPathが取れる
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            mockData[selectedIndexPath.row] = todo
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            // プロパティに追加してViewを更新
             mockData.insert(todo, at: 0)
             let newIndexPath = IndexPath(row: 0, section:  0)
             tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "AddTodo":
            os_log("Adding a new Todo.", log: .default, type: .debug)
        case "ShowTodo":
            // 選択したレコードのTodoを取得して遷移先のVCに事前に送り込む
            guard let destinationVC = segue.destination as? TodoDetailViewController else {
                return
            }
   
            guard let senderCell = sender as? TodoTableViewCell, let selectedIndexPath = tableView.indexPath(for: senderCell) else {
                return
            }

            destinationVC.todo = mockData[selectedIndexPath.row]
        default:
            fatalError("The TodoTableViewController received unknown segue")
        }
    }
}
