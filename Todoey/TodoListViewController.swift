//
//  ViewController.swift
//  Todoey
//
//  Created by EceOzturk on 21.08.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{

    
    var itemArray = ["A","B","C"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }


    
    override func tableView(_ _tableView:UITableView,numberOfRowsInSection section: Int) -> Int{
        return itemArray.count
    }
    override func tableView(_ _tableView:UITableView,cellForRowAt indexpath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexpath)
        cell.textLabel?.text = itemArray[indexpath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
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
            self.itemArray.append(alertText.text!)
            print(self.itemArray)
            self.tableView.reloadData()
            
        }
        
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

}

