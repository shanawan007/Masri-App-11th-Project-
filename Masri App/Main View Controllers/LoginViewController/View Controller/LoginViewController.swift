//
//  ViewController.swift
//  Masri App
//
//  Created by Temp on 04/03/2024.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        backGround.image = UIImage(named: "BackgroundImage")
        logoText.image = UIImage(named: "LogoText")
        haveAccount.text = "Don't have an account?"
        let attributedString = NSAttributedString(string: "Forget Password?", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        forgetTitle.setAttributedTitle(attributedString, for: .normal)
        
        login.setTitle("Login", for: .normal)
        login.layer.cornerRadius = 5
        
        checkButton.setImage(UIImage(named: "unchecked"), for: .normal)
        checkButton.setTitle("", for: .normal)
        rememberTitle.text = "Remember Me"
        appleTitle.setTitle("Continue with Apple", for: .normal)
        appleIcon.image = UIImage(named: "appleIcon")
        appleTitle.layer.cornerRadius = 5
        signUpTitle.setTitle("Sign Up", for: .normal)
        
        termsTitle.setTitle("Terms of Use", for: .normal)
        let attributedStringForTerms = NSAttributedString(string: "Terms of Use", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        termsTitle.setAttributedTitle(attributedStringForTerms, for: .normal)
        let attributedStringForPrivacy = NSAttributedString(string: "Privacy Policy", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        privacyTitle.setAttributedTitle(attributedStringForPrivacy, for: .normal)
        
        self.navigationItem.hidesBackButton = true
        progessView.isHidden = true
        
    }
    
    @IBOutlet weak var backGround: UIImageView!
    
    @IBOutlet weak var logoText: UIImageView!
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var emailError: UILabel!
    
    @IBAction func emailFieldType(_ sender: Any) {
        if let emailChange = userEmail.text
        {
            if let errorEmailField = validateEmail(emailChange){
                emailError.text = errorEmailField
                emailError.isHidden = false
            }
            else{
                emailError.isHidden = true
            }
        }
    }
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var checkButton: UIButton!
   
    @IBAction func checkChange(_ sender: UIButton) {
        guard let userEmail = userEmail.text else { return }
        guard let userPassword = password.text else { return }
        if sender.currentImage == UIImage(named: "unchecked") {
            sender.setImage(UIImage(named: "checked"), for: .normal)
            UserDefaults.standard.set(userEmail, forKey: "userEmail")
            UserDefaults.standard.set(userPassword, forKey: "userPassword")
        } else {
            sender.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    @IBOutlet weak var rememberTitle: UILabel!
    
    @IBOutlet weak var forgetTitle: UIButton!
    
    @IBAction func forgetPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let shareVC = storyboard.instantiateViewController(withIdentifier: "ForgetViewController") as! ForgetViewController
        
        shareVC.modalPresentationStyle = .fullScreen
        self.present(shareVC, animated: true)
        
        
    }
    
    @IBOutlet weak var login: UIButton!
    
    @IBAction func loginButton(_ sender: Any) {
        
        guard let emailUser = userEmail.text else { return }
        guard let passwordUser = password.text else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let loginUser = LoginModel(username: emailUser, password: passwordUser)
    
        if emailUser != "" && passwordUser != ""{
            self.progessView.isHidden = false
            LoginApiManager.shareInstance.callingLoginAPI(login: loginUser) { (result) in
                if result{
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        homeVC.modalPresentationStyle = .fullScreen
                        self.present(homeVC, animated: true)
                    }
                }
                else{
                    let alert = UIAlertController(title: "Alert", message: "User Not Found", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Cancel", style: .default)
                    alert.addAction(cancel)
                    self.present(alert, animated: true, completion: .none)
                }
            }
            
        }
        else{
                let alert = UIAlertController(title: "Submission", message: "Enter complete user details", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Cancel", style: .default)

                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBOutlet weak var appleTitle: UIButton!
    
    @IBAction func apple(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
//        let shareVC = storyboard.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuController
//        self.navigationController?.pushViewController(shareVC, animated: true)
//
        
    }
    
    @IBOutlet weak var appleIcon: UIImageView!
    
    @IBOutlet weak var haveAccount: UILabel!
    
    @IBOutlet weak var signUpTitle: UIButton!
    
    @IBAction func signUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let shareVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        shareVC.modalPresentationStyle = .fullScreen
        self.present(shareVC, animated: true)
        
    }
    
    @IBOutlet weak var termsTitle: UIButton!
    
    @IBAction func terms(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let shareVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(shareVC, animated: true)
    }

    @IBOutlet weak var privacyTitle: UIButton!
    
    @IBAction func PrivacyPolicy(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let shareVC = storyboard.instantiateViewController(withIdentifier: "PrivacyViewController") as! PrivacyViewController
        self.navigationController?.pushViewController(shareVC, animated: true)
    }
    
    @IBOutlet weak var progessView: UIView!
    
    func validateEmail(_ email: String) -> String? {
        var emailFirstError = "Please enter a valid email address"
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        if email.range(of: emailRegex, options: .regularExpression) == nil {
            return emailFirstError
        }
        return nil
    }

}

