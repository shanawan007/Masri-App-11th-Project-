//
//  AppointmentTableViewCell.swift
//  Masri App
//
//  Created by Temp on 05/04/2024.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dateAndTime: UILabel!
    
    
    @IBOutlet weak var followUp: UILabel!
    
    @IBOutlet weak var fullName: UILabel!
    
    @IBOutlet weak var addressOfDoctor: UILabel!
    
    
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layoutSubviews()
    }
    override func layoutSubviews() {
        
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 3, right: 0))

        self.backgroundColor = UIColor.black

    }
}
