//
//  ViewController.swift
//  TodoApp
//
//  Created by Rei Matsushita on 2020/09/21.
//  Copyright © 2020 Rei Matsushita. All rights reserved.
//

import UIKit
import os.log

class TodoDetailViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nav: UINavigationItem!
    
    var todo: TodoMock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if let todo = todo {
            titleTextField.text = todo.title
            contentTextView.text = todo.content
            nav.title = "Edit Todo"
        } else {
            nav.title = "Add Todo"
        }
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        os_log("CancelButton is pressed.")

        // 一つ前のVCで追加/編集かを判定できる
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if (isPresentingInAddMealMode) {
            // モーダルを閉じる
            dismiss(animated: true, completion: nil)
        } else if let owingNavigationController = navigationController {
            // 自身を取り除く
            owingNavigationController.popViewController(animated: true)
        } else {
            fatalError("The TodoDetailViewController is not inside a navigation controller.")
        }
    }

    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Segueが実行される際に必ず呼ばれる
        super.prepare(for: segue, sender: sender)

        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            os_log("SaveButton is not pressed.")
            return
        }

        os_log("SaveButton is pressed.")

        let title = titleTextField.text ?? ""
        let content = contentTextView.text ?? ""
        guard let todo = TodoMock(title: title, content: content) else {
            return
        }
        
        self.todo = todo
    }
}
