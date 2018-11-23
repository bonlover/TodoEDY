//
//  ToDoListViewController.swift
//  TodoEDY
//
//  Created by Yungdrung Gyaltsen on 11/19/18.
//  Copyright © 2018 Yungdrung Gyaltsen. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
                
    }
    
    //Mark - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //ternary operation ==>
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
 
    
    //Mark - TableView Delegate Methods and need to call context.save() to save data
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print("Index No: \(indexPath.row) : String: \( itemArray[indexPath.row])")
        
        //Delete Item from Table and need to call context.save() to save data
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
//        saveItems()
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //Update Item's value
//        itemArray[indexPath.row].setValue("Update Value", forKey: "title")
//        saveItems()
        
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New TodoEDY Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //what will happen once user clicks the Add Item button on our UIAlert
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            self.itemArray.append(newItem)
            self.saveItems()
          
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
  
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //MARK - Data manupulation methods
    
    func saveItems() {
        
        
        do {
            try  context.save()
        }
        catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate :NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES[cd] %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        }
        else{
            request.predicate = categoryPredicate
        }
        
        do {
            itemArray = try context.fetch(request)
        }
        catch {
            print("Error fetching data from context , \(error)")
        }
        tableView.reloadData()
    }
    
}

//MARK - Search bar methods

extension ToDoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]
        
        loadItems(with: request, predicate : predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            loadItems()
            
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
                
            }
            
        }
    }
    
}

