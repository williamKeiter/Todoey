//
//  CategoryViewController.swift
//  Todoey
//
//  Created by William Keiter on 9/27/18.
//  Copyright © 2018 William Keiter. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
	
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
//        let category = categories[indexPath.row]
        
        cell.textLabel?.text = categories[indexPath.row].name
        
//        cell.accessoryType = category.done == true ? .checkmark : .none
        
        return cell
    }

    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath =  tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }


    
    //MARK: - Add New Categories

    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert =  UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
          
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
        self.saveCategories()
            
            
        }
    
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add New Category"
            }
            
            present(alert, animated: true, completion: nil)
        
        }
    
    //MARK: - Data Manipulation Methods
    
    
    
            func loadCategories() {
    
                let request : NSFetchRequest<Category> = Category.fetchRequest()
    
                do {
                    categories = try context.fetch(request)
                } catch {
                    print("Error loading categories \(error)")
                }
                tableView.reloadData()
    
            }
    
    func saveCategories() {
    do {
    try context.save()
    } catch {
    print ("Error saving Category \(error)")
    }
    
    tableView.reloadData()
    }
            
    }

    






    
    
    
    
    
    
    
    

