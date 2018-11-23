//
//  CategoryViewController.swift
//  TodoEDY
//
//  Created by Yungdrung Gyaltsen on 11/21/18.
//  Copyright © 2018 Yungdrung Gyaltsen. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }

    // MARK: - TableView Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.name
        return cell
        
    }
    
    // MARK: - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }

    
    // MARK: - Data Manipulation  methods
    
    func saveCategory() {
        
        do {
            try  context.save()
        }
        catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        }
        catch {
            
            print("Error loading Categories , \(error)")
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Add New Categories
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle:.alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            self.saveCategory()
            
        }
        
        alert.addTextField { (alertTextField) in
            
           alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
}
