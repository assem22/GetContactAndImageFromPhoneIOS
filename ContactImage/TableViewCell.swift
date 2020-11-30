//
//  TableViewCell.swift
//  ContactImage
//
//  Created by Assem Mukhamadi on 28.11.2020.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
