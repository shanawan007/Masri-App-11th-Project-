//
//  SideMenuTable.swift
//  Masri App
//
//  Created by Temp on 07/03/2024.
//

import UIKit

class SideMenuTable: UITableViewCell {

    @IBOutlet weak var imageForLogo: UIImageView!
    
    @IBOutlet weak var headingForLogo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 100))
    }
}
