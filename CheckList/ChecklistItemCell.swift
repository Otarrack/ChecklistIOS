//
//  ChecklistItemCell.swift
//  CheckList
//
//  Created by Florian Van Den Berghe on 29/03/2018.
//  Copyright © 2018 Florian Van Den Berghe. All rights reserved.
//

import UIKit

class ChecklistItemCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemChecked: UILabel!
}
