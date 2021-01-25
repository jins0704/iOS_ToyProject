//
//  TodoTableViewController.swift
//  Todoey
//
//  Created by 홍진석 on 2021/01/24.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class TodoTableViewController: UITableViewController, UISearchBarDelegate {
    
    let realm = try! Realm()
    
    var selectedCategory : CategoryRealm?{
        didSet{
            loadItems()
        }
    }
    
    @IBOutlet weak var searchbar: UISearchBar!
    //var TodoList = Array<TodoItem>()
    var TodoList : Results<TodoItemRealm>?
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("TodoItem.plist")
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once after click
            //let newItem = TodoItem(context: self.context)
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write{
                        let newItem = TodoItemRealm()
                        newItem.title = textField.text!
                        currentCategory.TodoItems.append(newItem)
                    }
                }catch{
                    print("save error")
                }
            }
            
            self.tableView.reloadData()
            //newItem.parentCategory = self.selecetedCategory
            //self.TodoList.append(newItem)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source / delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TodoList?.count ?? 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todocell", for: indexPath)
        
        if let item = TodoList?[indexPath.row]{
            
            cell.textLabel?.text = item.title
            cell.accessoryType = item.check ? .checkmark : .none
            
        }else{
            cell.textLabel?.text = "nothing"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //TodoList[indexPath.row].check = !TodoList[indexPath.row].check
        //saveItem()
        if let item = TodoList?[indexPath.row]{
            do{
                try realm.write{
                    item.check = !item.check
                }
            }catch{
                print("save error")
            }
        }
        tableView.reloadData()
        //tableView.deselectRow(at: indexPath, animated: true)
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //context.delete(TodoList[indexPath.row])
            //TodoList.remove(at: indexPath.row)
            if let item = TodoList?[indexPath.row]{
                do{
                    try realm.write{
                        realm.delete(item)
                    }
                }catch{
                    print("delete error")
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Coredata function
    
    /*func saveItem(){
        do{
            try context.save()
        }catch{
            print("save error")
        }
        self.tableView.reloadData()
    }
    func loadItems(with request : NSFetchRequest<TodoItem> = TodoItem.fetchRequest(), predicate : NSPredicate? = nil){
       
        //let categorypredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selecetedCategory!.name!)
        
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate, additionalPredicate])
        }else{
            request.predicate = categorypredicate
        }
        
        do{
            TodoList = try context.fetch(request)
        }catch{
            print("fetch error")
        }
        tableView.reloadData()
    }*/
    
    func loadItems(){
        tableView.reloadData()
        TodoList = selectedCategory?.TodoItems.sorted(byKeyPath: "title", ascending: true)
        
    }
    
    // MARK: - Search bar methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //let predicate = NSPredicate(format: "title Contains[cd] %@", searchbar.text!)
        //let request : NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        //request.predicate = predicate
        //let descriptor = NSSortDescriptor(key: "title", ascending: true)
        //request.sortDescriptors = [descriptor]
        
        //loadItems(with: request,predicate: predicate)
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchbar.text?.count == 0{
            loadItems()
            
            DispatchQueue.main.async {
                self.searchbar.resignFirstResponder()
            }
        }
    }
}
