//
//  CheckListItem.swift
//  CheckList
//
//  Created by Florian Van Den Berghe on 08/03/2018.
//  Copyright © 2018 Florian Van Den Berghe. All rights reserved.
//

import Foundation

class ChecklistItem: Codable {
    var text: String
    var checked: Bool
    
    init(text: String, checked: Bool = false) {
        self.text = text
        self.checked = checked
    }
    
    func toggleChecked() -> Void {
        checked = !checked
    }
}
