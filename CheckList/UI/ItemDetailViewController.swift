//
//  AddItemViewController.swift
//  CheckList
//
//  Created by Florian Van Den Berghe on 08/03/2018.
//  Copyright © 2018 Florian Van Den Berghe. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var itemNameText: UITextField!
    var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit: ChecklistItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let itemToEdit = itemToEdit {
            itemNameText.text = itemToEdit.text
            navigationItem.title = "Edit Item"
        }
    }
    
    @IBAction func done() {
        if let itemToEdit = itemToEdit {
            itemToEdit.text = itemNameText.text!
            delegate?.ItemDetailViewController(self, didFinishEditingItem: itemToEdit)
        } else {
            delegate?.ItemDetailViewController(self, didFinishAddingItem: ChecklistItem(text: itemNameText.text!))
        }
    }

    @IBAction func cancel() {
        delegate?.ItemDetailViewControllerDidCancel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        itemNameText.becomeFirstResponder()
        itemNameText.delegate = self
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if let oldString = textField.text {
            let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!,with: string)
            if(newString.count == 0)
            {
                navigationItem.rightBarButtonItem?.isEnabled = false
            }
            else
            {
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
        return true
    }

}

protocol ItemDetailViewControllerDelegate : class {
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}
