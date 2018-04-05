//
//  ViewController.swift
//  CheckList
//
//  Created by Florian Van Den Berghe on 01/03/2018.
//  Copyright © 2018 Florian Van Den Berghe. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
        
    var itemList = Array<ChecklistItem>()
    var list: Checklist!
    var documentDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    var dataFileUrl: URL {
        return documentDirectory.appendingPathComponent("Checklists").appendingPathExtension("json")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = list.name
    }
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem) {
        let myCell = cell as! ChecklistItemCell
        myCell.itemChecked.isHidden = (item.checked) ? false : true
    }
    
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem){
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
        
        saveChecklistItems()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        itemList.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        saveChecklistItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.topViewController as! ItemDetailViewController
            destVC.delegate = self as ItemDetailViewControllerDelegate
        }
        if segue.identifier == "editItem" {
            let destination = segue.destination as! UINavigationController
            let targetController = destination.topViewController as! ItemDetailViewController
            let index = tableView.indexPath(for: sender as! ChecklistItemCell)!
            targetController.itemToEdit = itemList[index.row]
            targetController.delegate = self
        }
    }
    
}

// MARK: - AddItemViewControllerDelegate
extension ChecklistViewController: ItemDetailViewControllerDelegate {
    
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        controller.dismiss(animated: true)
    }
    
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        itemList.append(item)
        tableView.reloadData()
        
        saveChecklistItems()
        controller.dismiss(animated: true)
    }
    
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        let index = itemList.index(where:{ $0 === item })!
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        
        saveChecklistItems()
        controller.dismiss(animated: true)
        
    }
}

// MARK: - Save/Load ChecklistItem
extension ChecklistViewController {

    func saveChecklistItems(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(itemList)
        print(String(data: data, encoding: .utf8)!)
        try! data.write(to: dataFileUrl)
    }
    
    func loadChecklistItems(){
        if FileManager.default.fileExists(atPath: dataFileUrl.path) {
            let data = try? Data(contentsOf: dataFileUrl)
            let decoder = JSONDecoder()
            let itemsLoaded = try? decoder.decode(Array<ChecklistItem>.self, from: data!)
            itemList = itemsLoaded!
        }
    }
    
    override func awakeFromNib(){
        loadChecklistItems()
    }
}

