//
//  ViewController.swift
//  Todoey
//
//  Created by JOHN ZZN on 7/16/19.
//  Copyright © 2019 John Zhou. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["FINd", "Buy eggs", "Destroy"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK - TableView DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]

        
        return cell
    }


    // MARK - TableView Delegate Method

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK - Add new item
    @IBAction func addButtomPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new To-Do Item", message: nil, preferredStyle: .alert)

        let action = UIAlertAction(title: "aDD iTEM", style: .default) { (action) in
            self.itemArray.append(textField.text ?? "")

            // use this method to reload data in the table view
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}

