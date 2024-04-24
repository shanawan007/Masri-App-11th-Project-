//
//  TermsViewController.swift
//  Masri App
//
//  Created by Temp on 04/03/2024.
//

import UIKit

class TermsViewController: UIViewController {

    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBAction func backButton(_ sender: Any) {
        
       dismiss(animated: true)
    }
    
    
    @IBAction func start(_ sender: Any) {
        
//        progress.startAnimating()
    }
    
    
    
    @IBAction func close(_ sender: Any) {
//        progress.stopAnimating()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    


}
