//
//  ViewController.swift
//  Todoey
//
//  Created by EceOzturk on 21.08.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{

    
    var itemArray = [Item]()
    
    var selectedCategory : Category?
    {
        didSet{
            loadItem()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        print(itemArray)        
    }


    
    override func tableView(_ _tableView:UITableView,numberOfRowsInSection section: Int) -> Int{
        return itemArray.count
    }
    override func tableView(_ _tableView:UITableView,cellForRowAt indexpath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexpath)
        
        let item = itemArray[indexpath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        /*context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)*/
        
        
        self.saveItem()
        tableView.reloadData()
        
       
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)
        var alertText = UITextField()
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create Item"
            alertText = alertTextField
            
        }
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            print("success")
            
            print(alertText.text!)
            

            let newItem = Item(context: self.context)
            newItem.done = false
            
            newItem.title = alertText.text!
            
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            print(self.itemArray)
            
            self.saveItem()
            
            
        }
        
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItem()
    {
        do{

            try context.save()
        }
        catch{
            print("error saving context \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadItem(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil){
        
        /*if let data = try? Data.init(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            
            do {
                itemArray = try decoder.decode([Item].self, from: data)
                
            } catch  {
                print(error)
            }
        }*/
        
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@ ", selectedCategory!.name!)
        
        if let additionelPredicate = predicate
        {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionelPredicate])
        }
        else{
            request.predicate = categoryPredicate
        }
        
        
        do {
            itemArray = try context.fetch(request)
        } catch  {
            print("Fetching error data from context \(error)")
        }
        
        
      
    }
    

}

//Mark: - Search bar methods
extension TodoListViewController : UISearchBarDelegate
{
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("yesss")
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        print(searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItem(with: request,predicate: predicate)
        
    }
    
    func  searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0
        {
            loadItem()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
    }
}

