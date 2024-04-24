//
//  SideMenuController.swift
//  Masri App
//
//  Created by Temp on 07/03/2024.
//

import UIKit
import SideMenu
class SideMenuController: UIViewController{
    
    var user = UserDefaults.standard.string(forKey: "userEmail")
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var settingImage: UIImageView!
    
    
    @IBOutlet weak var NewsAndPromotion: UIButton!
    
    
    @IBAction func newsAndPromotionAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let shareVC = storyboard.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
        shareVC.modalPresentationStyle = .fullScreen
        self.present(shareVC, animated: true)
        
    }
    
    
    @IBOutlet weak var settingImage2: UIImageView!
    
    
    @IBOutlet weak var OurServices: UIButton!
    
    
    @IBAction func ourServiceButton(_ sender: Any) {
        let storyboard2 = UIStoryboard(name: "OurServices", bundle: nil)
        let shareVC = storyboard2.instantiateViewController(withIdentifier: "OurServicesViewController") as! OurServicesViewController
        shareVC.modalPresentationStyle = .fullScreen
        self.present(shareVC, animated: true)

    }
    
    
    @IBOutlet weak var changePasswordImage: UIImageView!
    
    
    
    @IBOutlet weak var changePasswordLabel: UIButton!
    
    
    @IBAction func changePassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let shareVC = storyboard.instantiateViewController(withIdentifier: "ForgetViewController") as! ForgetViewController
        shareVC.modalPresentationStyle = .fullScreen
        self.present(shareVC, animated: true)
        //self.navigationController?.pushViewController(shareVC, animated: true)
    }
    
    @IBOutlet weak var logoutImage: UIImageView!
    
    @IBOutlet weak var logoutLabel: UIButton!
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "userEmail")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let shareVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        shareVC.modalPresentationStyle = .fullScreen
        self.present(shareVC, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingImage.image = UIImage(named: "dateTime")
        settingImage2.image = UIImage(named: "dateTime")
        changePasswordImage.image = UIImage(named: "changePassword")
        logoutImage.image = UIImage(named: "Logout")
        self.navigationItem.titleView?.isHidden = true
        
        userName.text = user
    }
    
}
