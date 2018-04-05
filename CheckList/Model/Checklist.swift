//
//  Checklist.swift
//  CheckList
//
//  Created by Florian Van Den Berghe on 05/04/2018.
//  Copyright © 2018 Florian Van Den Berghe. All rights reserved.
//

import UIKit

class Checklist: Codable {
    var name: String
    var items: [ChecklistItem]
    
    init(name: String, items: [ChecklistItem] = []) {
        self.name = name
        self.items = items
    }
}
