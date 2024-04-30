//
//  OurServicesViewController.swift
//  Masri App
//
//  Created by Temp on 08/03/2024.
//

import UIKit

class OurServicesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVC()
        facialBtnLable.layer.cornerRadius = 5
        bodyBtnLable.layer.cornerRadius = 5
        backIcon.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backIcon.setTitle("", for: .normal)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBOutlet weak var backIcon: UIButton!
    
    @IBOutlet weak var facialContainer: UIView!

    @IBOutlet weak var bodyContainer: UIView!
    
    @IBOutlet weak var facialBtnLable: UIButton!
    
    @IBAction func facial(_ sender: UIButton) {
        
        facialContainer.isHidden = false
        bodyContainer.isHidden = true
    }
    
    @IBOutlet weak var bodyBtnLable: UIButton!
    
    @IBAction func body(_ sender: UIButton) {
        facialContainer.isHidden = true
        bodyContainer.isHidden = false
        
    }
    
    func setVC(){
        facialContainer.isHidden = false
        bodyContainer.isHidden = true
    }
}
