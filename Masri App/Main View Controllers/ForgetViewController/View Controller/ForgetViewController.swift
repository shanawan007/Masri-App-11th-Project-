//
//  ForgetViewController.swift
//  Masri App
//
//  Created by Temp on 04/03/2024.
//

import UIKit

class ForgetViewController: UIViewController {
    
    var otp: String = "123142312312"
    
    var forgetArray : [ForgetModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ForgetTitle.text = "Password Reset"
        cancelTitle.layer.cornerRadius = 5
        nextTitle.setTitle("Next", for: .normal)
        nextTitle.layer.cornerRadius = 5
        self.navigationItem.hidesBackButton = true
        newPassword.isHidden = true
        confirmPassword.isHidden = true
        submitBtn.isHidden = true
        activityView.isHidden = true
    }
    
    @IBOutlet weak var ForgetTitle: UILabel!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var emailErrorTitle: UILabel!
    
    @IBAction func emailErr(_ sender: Any) {
        if let emailChange = emailField.text
        {
            if let errorEmailField = validateEmail(emailChange){
                
                emailErrorTitle.text = errorEmailField
                emailErrorTitle.isHidden = false
            }
            else {
                emailErrorTitle.isHidden = true
            }
            
        }
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBOutlet weak var cancelTitle: UIButton!
    
    @IBOutlet weak var nextTitle: UIButton!
    
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBAction func saveButton(_ sender: Any) {
        if newPassword.text == "" || newPassword.text!.count == 0 {
            let alert = UIAlertController(title: "Submission", message: "Enter confirm password", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default)
            
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            
        }
        else if confirmPassword.text == "" || confirmPassword.text!.count == 0 {
            let alert = UIAlertController(title: "Submission", message: "Enter confirm password", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default)
            
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        
        let userFound = UserDefaults.standard.string(forKey: "userEmail")
        
        let userOTP = otp
        guard let passwordUser = newPassword.text else { return }
        guard let confirmPasswordUser = confirmPassword.text else { return }
        
        let userInfo = ForgetModel(username: userFound!, otp: userOTP, password: passwordUser)
        
        if passwordUser == confirmPasswordUser{
            activityView.isHidden = false
                ForgetApiManager.shareInstance.callingForgetAPI(forget: userInfo,completionHandler: { (result) in
                    if result {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let shareVC = storyboard.instantiateViewController(withIdentifier:"HomeViewController") as! HomeViewController
                            shareVC.modalPresentationStyle = .fullScreen
                            self.present(shareVC, animated: true)
                            
                            }
                        self.activityView.isHidden = true
                    }
                    else{
                        print("Failure to pass")
                            
                    }
                    }
                    
                )
        }
        else{
           let alert = UIAlertController(title: "Submission", message: "Password Do Not Match", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Cancel", style: .default)
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
            self.activityView.isHidden = true
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        checkingDetails()
        let userFound = UserDefaults.standard.string(forKey: "userEmail")
        if emailField.text == userFound {
            let alert = UIAlertController(title: "Alert!", message: "User Found", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { alert in
                self.newPassword.isHidden = false
                self.confirmPassword.isHidden = false
                self.submitBtn.isHidden = false
            })
            
            alert.addAction(cancel)
            
            emailField.isHidden = true
            cancelTitle.isHidden = true
            nextTitle.isHidden = true
            
            present(alert, animated: true, completion: nil)
            
        }
        else{
            let alert = UIAlertController(title: "Alert!", message: "Wrong Credentials", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Cancel", style: .default)
            
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBOutlet weak var submitBtn: UIButton!
   
    @IBOutlet weak var activityView: UIView!
    
    func checkingDetails(){
        
        if emailField.text == "" || emailField.text!.count == 0 {
            let alert = UIAlertController(title: "Alert!", message: "Please Enter Your Correct Email", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default)
            
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func validateEmail(_ email: String) -> String? {
        var emailFirstError = "Please enter a valid email address"
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        if email.range(of: emailRegex, options: .regularExpression) == nil {
            return emailFirstError
        }
        return nil
    }
}
