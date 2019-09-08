//
//  CategoryViewController.swift
//  Todoey
//
//  Created by EceOzturk on 4.09.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(categoryArray)
        
        loadItem()



    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let name = categoryArray[indexPath.row]
        
        cell.textLabel?.text = name.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexpath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categoryArray[indexpath.row]
        }
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todoey category", message: "", preferredStyle: .alert)
       
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            print(textField.text!)
            let category = Category(context: self.context)
            category.name = textField.text!
            self.categoryArray.append(category)
            self.saveCategory()
            
            
        }
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add new category"
        }
        
        present(alert,animated: true,completion: nil)
            
        
    }
    
    func saveCategory() {
        do{
            
            try context.save()
        }
        catch{
            print("error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItem(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        
        /*if let data = try? Data.init(contentsOf: dataFilePath!){
         let decoder = PropertyListDecoder()
         
         do {
         itemArray = try decoder.decode([Item].self, from: data)
         
         } catch  {
         print(error)
         }
         }*/
        
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            categoryArray = try context.fetch(request)
        } catch  {
            print("Fetching error data from context \(error)")
        }
        
        
        
    }
}
