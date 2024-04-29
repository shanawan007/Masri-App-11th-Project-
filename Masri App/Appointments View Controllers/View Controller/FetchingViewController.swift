//
//  FetchingViewController.swift
//  Masri App
//
//  Created by Temp on 24/04/2024.
//

import UIKit

class FetchingViewController: UIViewController {

    
    
    @IBOutlet weak var activityProgress: UIActivityIndicatorView!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        activityProgress.startAnimating()
        
        // Do any additional setup after loading the view.
    }
}
