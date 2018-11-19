//
//  ToDoListViewController.swift
//  TodoEDY
//
//  Created by Yungdrung Gyaltsen on 11/19/18.
//  Copyright © 2018 Yungdrung Gyaltsen. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["find Mike", "Buy Eggs", "Travel to Mustang"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //Mark - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

    
    //Mark - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print("Index No: \(indexPath.row) : String: \( itemArray[indexPath.row])")
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New TodoEDY Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //what will happen once user clicks the Add Item button on our UIAlert
            
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
//            print(alertTextField.text)
//            print("Now")
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
}

