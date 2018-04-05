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
        let myCell = cell as! ChecklistItemCell
        myCell.itemChecked.isHidden = (item.checked) ? false : true
    }
    
    func configureText(for cell: UITableViewCell, withItem item: CheckListItem){
        let myCell = cell as! ChecklistItemCell
        myCell.itemName.text = item.text
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.topViewController as! AddItemViewController
            destVC.delegate = self as AddItemViewControllerDelegate
        }
        if segue.identifier == "editItem" {
            let destination = segue.destination as! UINavigationController
            let targetController = destination.topViewController as! AddItemViewController
            let index = tableView.indexPath(for: sender as! ChecklistItemCell)!
            targetController.itemToEdit = itemList[index.row]
            targetController.delegate = self
        }
    }
}

// MARK: - AddItemViewControllerDelegate
extension CheckListViewController: AddItemViewControllerDelegate {
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        controller.dismiss(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: CheckListItem) {
        itemList.append(item)
        tableView.reloadData()
        controller.dismiss(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: CheckListItem) {
        let index = itemList.index(where:{ $0 === item })!
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        controller.dismiss(animated: true)
        
    }
}

