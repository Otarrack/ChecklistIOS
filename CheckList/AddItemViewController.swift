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
    
    @IBAction func done() {
        print(itemNameText)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
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
