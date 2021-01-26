//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by 홍진석 on 2021/01/25.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    
    //var CategoryList = Array<Category>()
    var CategoryList : Results<CategoryRealm>?
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "1D9Bf6")
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what will happen once after click
            
            //let newCategory = Category(context: self.context)
            let newCategory = CategoryRealm()
            newCategory.name = textField.text!
            newCategory.hexColor = UIColor.randomFlat().hexValue()
            
            //self.CategoryList.append(newCategory)
            
            self.saveCategory(category: newCategory)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source, delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CategoryList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorycell", for: indexPath)
        
        cell.backgroundColor = UIColor(hexString: (CategoryList?[indexPath.row].hexColor) ?? "1D9Bf6")
        cell.textLabel?.text = CategoryList?[indexPath.row].name ?? "Nothing"
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor ?? UIColor.black, returnFlat: true)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //context.delete(CategoryList[indexPath.row])
            if let category = CategoryList?[indexPath.row]{
                do{
                    for item in category.TodoItems{
                        do{
                            try realm.write{
                                realm.delete(item)
                            }
                        }catch{
                            print("item delete error")
                        }
                    }
                    try realm.write{
                        realm.delete(category)
                    }
                }catch{
                    print("delete error")
                }
                //CategoryList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! TodoTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            dest.selectedCategory = CategoryList?[indexPath.row]
        }
    }
    
    
    // MARK: - Coredata function
    func saveCategory(category: CategoryRealm){
        do{
            //try context.save()
            try realm.write{
                realm.add(category)
            }
        }catch{
            print("save error")
        }
        self.tableView.reloadData()
    }
    
    /*func loadCategory(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        do{
           //CategoryList = try context.fetch(request)
        }catch{
            print("fetch error")
        }
        tableView.reloadData()
    }*/
    
    func loadCategory(){
        CategoryList = realm.objects(CategoryRealm.self)
        
        tableView.reloadData()
    }
}
