//
//  MultiChoiceTableViewCell.swift
//  PulseMD
//
//  Created by Joseph Richardson on 11/6/16.
//  Copyright © 2016 Joseph Richardson. All rights reserved.
//

import UIKit

class MultiChoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var multiChoice : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
