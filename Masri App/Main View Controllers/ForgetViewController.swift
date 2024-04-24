//
//  ForgetViewController.swift
//  Masri App
//
//  Created by Temp on 04/03/2024.
//

import UIKit

class ForgetViewController: UIViewController {

    @IBOutlet weak var ForgetTitle: UILabel!
    
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var emailErrorTitle: UILabel!
    
    var otp: String = "123142312312"
    
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
        
        else if confirmPassword.text != newPassword.text{
            let alert = UIAlertController(title: "Submission", message: "Password do not match", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default)
            
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        
        
        guard let passwordUser = confirmPassword.text else { return }
        
        let username = UserDefaults.standard.string(forKey: "userEmail")
        //let otpCode = UserDefaults.standard.string(forKey: "otp")
        let forgetPasswordUser = ForgetModel(username: username!, otp: otp, password: passwordUser)
        
        if passwordUser != ""{
            ApiManager.shareInstance.callingForgetAPI(forget: forgetPasswordUser, completionHandler: { (result) in
                if result{
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let shareVC = storyboard.instantiateViewController(withIdentifier:"HomeViewController") as! HomeViewController
                        self.navigationController?.popToViewController(shareVC, animated: true)
                    }
                    
                }
                else{
                    print("Failure to pass")
                        
                }
                })
        }}
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ForgetTitle.text = "Password Reset"
        cancelTitle.setTitle("Cancel", for: .normal)
        cancelTitle.layer.cornerRadius = 5
        nextTitle.setTitle("Next", for: .normal)
        nextTitle.layer.cornerRadius = 5
        self.navigationItem.hidesBackButton = true
        newPassword.isHidden = true
        confirmPassword.isHidden = true
        submitBtn.isHidden = true
    }

    
    
    
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
