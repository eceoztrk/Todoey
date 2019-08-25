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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        print(dataFilePath)
        
        print(itemArray)
        
        loadItem()
        
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
        self.saveItem()
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
            
            self.saveItem()
            
            
        }
        
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItem()
    {
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try
                data.write(to: dataFilePath!)
            
        }
        catch{
            print(error)
        }
        self.tableView.reloadData()
        
    }
    
    func loadItem(){
        
        if let data = try? Data.init(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            
            do {
                itemArray = try decoder.decode([Item].self, from: data)
                
            } catch  {
                print(error)
            }
        }
        
      
    }
    

}

