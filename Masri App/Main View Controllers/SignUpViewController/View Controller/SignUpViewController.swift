//
//  SignUpViewController.swift
//  Masri App
//
//  Created by Temp on 04/03/2024.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var control: Int = 0
    
    let datePick = UIDatePicker()
    
    var selectGender: String = "male"
    
    var device_tokens: String = "123456789"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        backGround.image = UIImage(named: "BackgroundImage")
        logoText.image = UIImage(named: "LogoText")
        
        firstImage.image = UIImage(named: "strk")
        lastImage.image = UIImage(named: "strk")
        emailImage.image = UIImage(named: "strk")
        
        passwordImage.image = UIImage(named: "strk")
        confirmPasswordImage.image = UIImage(named: "strk")
        signUpTitle.setTitle("SIGN UP", for: .normal)
        haveAccount.text = "Already have an account?"
        loginTitle.setTitle("LOGIN", for: .normal)
        
        birthDateImage.image = UIImage(named: "DateOfBirthIcon")
        
        birthDate.addTarget(self, action: #selector(dateSet), for: .touchDown)
        
        datePick.preferredDatePickerStyle = .wheels
        datePick.datePickerMode = .date
        
    }
    
    @IBOutlet weak var backGround: UIImageView!
    
    @IBOutlet weak var logoText: UIImageView!
    
    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var firstImage: UIImageView!
    
    @IBOutlet weak var firstNameError: UILabel!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var lastImage: UIImageView!
    
    @IBOutlet weak var lastNameError: UILabel!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var emailImage: UIImageView!
    
    @IBOutlet weak var emailError: UILabel!
    
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var phoneNumberError: UILabel!
    
    @IBOutlet weak var birthDate: UITextField!
    
    @IBOutlet weak var birthDateImage: UIImageView!
    
    @IBAction func male(_ sender: Any) {
        
        selectGender = "male"
        print(selectGender)
    }
    
    @IBAction func female(_ sender: Any) {
        
        selectGender = "female"
        print(selectGender)
    }
    
    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet weak var passwordImage: UIImageView!

    @IBOutlet weak var passwordError: UILabel!

    @IBOutlet weak var confirmPasswordField: UITextField!

    @IBOutlet weak var confirmPasswordImage: UIImageView!

    @IBOutlet weak var confirmPasswordError: UILabel!

    @IBOutlet weak var signUpTitle: UIButton!

    @IBOutlet weak var haveAccount: UILabel!

    @IBAction func loginBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let shareVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        shareVC.modalPresentationStyle = .fullScreen
        self.present(shareVC, animated: true)
    }
    
    @IBAction func firstFieldButton(_ sender: Any)
    {
        if let firstnameChange = firstNameField.text
        {
            if let errorFirstField = validateName(firstnameChange){
                firstNameError.text = errorFirstField
                firstNameError.isHidden = false
            }
            else{
                firstNameError.isHidden = true
            }
        }
    }

    @IBAction func lastFieldButton(_ sender: Any) {
        if let lastnameChange = lastNameField.text
        {
            if let errorLastField = validateName(lastnameChange){
                lastNameError.text = errorLastField
                lastNameError.isHidden = false
            }
            else{
                lastNameError.isHidden = true
            }
        }
    }

    @IBAction func emailFieldButton(_ sender: Any) {
        if let emailChange = emailField.text
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

    @IBAction func phoneFieldButton(_ sender: Any) {
        if let phoneChange = phoneField.text
        {
            if let errorPhoneField = validatePhoneNumber(phoneChange){
                phoneNumberError.text = errorPhoneField
                phoneNumberError.isHidden = false
            }
            else{
                phoneNumberError.isHidden = true
            }
        }
    }

    @IBOutlet weak var loginTitle: UIButton!
    
    @objc func dateSet(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([doneBtn], animated: true)
            
        birthDate.inputAccessoryView = toolbar
        birthDate.inputView = datePick
        
    }
    
    @objc func doneClicked(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        birthDate.text = formatter.string(from: datePick.date)
        
        self.view.endEditing(true)
        
    }
    
    func checkingDetails(){
        
        if firstNameField.text == "" || firstNameField.text!.count == 0 {
            let alert = UIAlertController(title: "Submission", message: "Enter first name", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default)
            
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        
        else if lastNameField.text == "" || lastNameField.text!.count == 0 {
            let alert = UIAlertController(title: "Submission", message: "Enter last name", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default)
            
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        else if emailField.text == "" || emailField.text!.count == 0 {
            let alert = UIAlertController(title: "Submission", message: "Enter email", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default)
            
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        else if phoneField.text == "" || phoneField.text!.count == 0 {
            let alert = UIAlertController(title: "Submission", message: "Enter phone number", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default)
            
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        else if passwordField.text == "" || passwordField.text!.count == 0 {
            let alert = UIAlertController(title: "Submission", message: "Enter password", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default)

            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        else if confirmPasswordField.text == "" || confirmPasswordField.text!.count == 0 {
            let alert = UIAlertController(title: "Submission", message: "Enter confirm password", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default)

            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }

        else if confirmPasswordField.text != passwordField.text{
            let alert = UIAlertController(title: "Submission", message: "Password do not match", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default)

            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        checkingDetails()
        guard let firstnameUser = self.firstNameField.text else {return}
        guard let lastnameUser = self.lastNameField.text else {return}
        guard let emailUser = self.emailField.text else {return}
        guard let passwordUser = self.passwordField.text else {return}
        guard let dobUser = self.birthDate.text else {return}
        guard let num = self.phoneField.text else {return}
        
        let registers = Registeration(first_name: firstnameUser, last_name: lastnameUser, email: emailUser,phone: num, password: passwordUser, gender: selectGender,dob: dobUser, device_token: device_tokens)
        
        SignupApiManager.shareInstance.callingRegisterAPI(register: registers, completion: {
            success in
            if success{
                let alert = UIAlertController(title: "Alert", message: "User Register Successfully", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Cancel", style: .default)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: .none)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let shareVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController

                self.modalPresentationStyle = .fullScreen
                self.present(shareVC, animated: true)
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "Email Found, Please enter new email", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Cancel", style: .default)

                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
                print("User Found")
            
            }})
    }
    
    func validateName(_ firstName: String) -> String? {
        let firstError = "Name should only contain alphabetic characters"
        let secondError = "Name should have at least 2 characters"
        
        let invalidCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").inverted
        if firstName.rangeOfCharacter(from: invalidCharacters) != nil {
            return firstError
        } else if firstName.count < 2 {
            return secondError
        }
        return nil
    }
    
    func validateEmail(_ email: String) -> String? {
        var emailFirstError = "Please enter a valid email address"
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        if email.range(of: emailRegex, options: .regularExpression) == nil {
            return emailFirstError
        }
        return nil
    }
    
    func validatePhoneNumber(_ phoneNumber: String) -> String? {
        let phoneRegex = #"^\d{11}$"#
        if phoneNumber.range(of: phoneRegex, options: .regularExpression) == nil {
            return "Please enter a valid 11-digit phone number"
        }
        return nil
    }
}
