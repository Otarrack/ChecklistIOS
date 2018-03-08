//
//  ViewController.swift
//  CheckList
//
//  Created by Florian Van Den Berghe on 01/03/2018.
//  Copyright © 2018 Florian Van Den Berghe. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {
    var itemList = Array<CheckListItem>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemList.append(CheckListItem(text: "Tester l'appli", checked: true))
        itemList.append(CheckListItem(text: "Debugger l'appli"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: CheckListItem) {
        cell.accessoryType = (item.checked) ? .checkmark : .none
    }
    
    func configureText(for cell: UITableViewCell, withItem item: CheckListItem){
        cell.textLabel?.text = item.text
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        configureText(for: cell, withItem: itemList[indexPath.item])
        configureCheckmark(for: cell, withItem: itemList[indexPath.item])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        itemList[indexPath.item].toggleChecked()
        configureCheckmark(for: cell, withItem: itemList[indexPath.item])
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        itemList.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func addDummyTodo(_ sender: Any) {
        itemList.append(CheckListItem(text: "New item"))
        tableView.reloadData()
    }
}

