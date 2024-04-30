//
//  activityOnForgetViewController.swift
//  Masri App
//
//  Created by Temp on 30/04/2024.
//

import UIKit

class activityOnForgetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        progressiveIcon.startAnimating()
    }
    
    
    @IBOutlet weak var progressiveIcon: UIActivityIndicatorView!
}
