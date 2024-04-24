//
//  FacialTableViewCell.swift
//  Masri App
//
//  Created by Temp on 26/03/2024.
//

import UIKit

class FacialTableViewCell: UITableViewCell {

    
    @IBOutlet weak var displayImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutSubviews()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        
        self.backgroundColor = UIColor.black
        
    }
    
}
