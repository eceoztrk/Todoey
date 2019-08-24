//
//  ViewController.swift
//  Todoey
//
//  Created by EceOzturk on 21.08.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{

    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem1 = Item()
        newItem1.title = "Ece"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Ece"
        itemArray.append(newItem2)
        let newItem3 = Item()
        newItem3.title = "Ece"
        itemArray.append(newItem3)
        
        
        if let items = defaults.array(forKey: "ToDoList") as? [Item]
        {
            itemArray = items
        }
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
        
        tableView.reloadData()
        
       
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "add new todoey item", message: "", preferredStyle: .alert)
        var alertText = UITextField()
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create Item"
            alertText = alertTextField
            
        }
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            print("success")
            
            print(alertText.text!)
            let newItem = Item()
            newItem.title = alertText.text!
            self.itemArray.append(newItem)
            print(self.itemArray)
            
            self.defaults.set(self.itemArray, forKey: "ToDoList")
            
            self.tableView.reloadData()
            
        }
        
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

}

