//
//  TableViewCell.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 23.06.21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var taskId: Int?

    @IBOutlet weak var title: UILabel!
    //    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
