//
//  ProgressViewController.swift
//  Masri App
//
//  Created by Temp on 16/04/2024.
//

import UIKit

class ProgressViewController: UIViewController {
    
    @IBOutlet weak var progressive: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressive.startAnimating()
        
    }
    
    
    

}
