//
//  ViewController.swift
//  Todoey
//
//  Created by JOHN ZZN on 7/16/19.
//  Copyright © 2019 John Zhou. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [ItemData]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")



    override func viewDidLoad() {
        super.viewDidLoad()

        loadItem()

    }

    // MARK - TableView DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title

        cell.accessoryType = itemArray[indexPath.row].checked ? .checkmark : .none
        return cell
    }


    // MARK - TableView Delegate Method

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].checked = !itemArray[indexPath.row].checked
        saveItem()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK - Add new item
    @IBAction func addButtomPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new To-Do Item", message: nil, preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = ItemData()
            newItem.title = textField.text ?? ""
            self.itemArray.append(newItem)
            self.saveItem()
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

    func loadItem() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([ItemData].self, from: data)
            } catch {
                print("\(error)")
            }
        }
    }

    func saveItem() {
        let encoder = PropertyListEncoder()

        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch  {
            print("\(error)")
        }

        self.tableView.reloadData()
    }

}

