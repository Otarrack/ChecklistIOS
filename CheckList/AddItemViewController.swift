//
//  AddItemViewController.swift
//  CheckList
//
//  Created by Florian Van Den Berghe on 08/03/2018.
//  Copyright © 2018 Florian Van Den Berghe. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var itemNameText: UITextField!
    var delegate: AddItemViewControllerDelegate?
    var itemToEdit: CheckListItem?

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
            delegate?.addItemViewController(self, didFinishEditingItem: itemToEdit)
        } else {
            delegate?.addItemViewController(self, didFinishAddingItem: CheckListItem(text: itemNameText.text!))
        }
    }

    @IBAction func cancel() {
        delegate?.addItemViewControllerDidCancel(self)
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

protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: CheckListItem)
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: CheckListItem)
}
