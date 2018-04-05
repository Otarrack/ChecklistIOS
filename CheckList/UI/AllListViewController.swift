//
//  AllListViewController.swift
//  CheckList
//
//  Created by Florian Van Den Berghe on 05/04/2018.
//  Copyright © 2018 Florian Van Den Berghe. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

    var lists: [Checklist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        lists = [Checklist(name: "Liste 1"),Checklist(name: "Liste 2")]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: .automatic)
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
