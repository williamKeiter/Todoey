//
//  CategoryViewController.swift
//  Todoey
//
//  Created by William Keiter on 9/27/18.
//  Copyright © 2018 William Keiter. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        tableView.separatorStyle = .none
        	
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "25A4FE")
        
//        print(cell.backgroundColor?.hexValue() as Any)
        //take hex value and assign to array for cell and persist in realm?
        
        return cell
    }

    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath =  tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }


    
    //MARK: - Add New Categories

    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert =  UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
          
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()

            
            
            self.save(category: newCategory)
            
            
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
            
            categories = realm.objects(Category.self)

            tableView.reloadData()
        }
    
        func save(category: Category) {
            do {
                try realm.write {
                    realm.add(category)
                }
            } catch {
                print ("Error saving Category \(error)")
    }
    tableView.reloadData()
    }
    
    //Mark: - Delete data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                    }
                } catch{
                    print("Error deleting category, \(error)")
                }
            }
        }
    
            
}








    
    
    
    
    
    
    
    

