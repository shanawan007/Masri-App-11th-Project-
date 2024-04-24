//
//  AppointmentViewController.swift
//  Masri App
//
//  Created by Temp on 19/03/2024.
//

import UIKit
import SideMenu
import Alamofire

class AppointmentViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,SideMenuNavigationControllerDelegate {
   
    let datePickForStart = UIDatePicker()
    let datePickForEnd = UIDatePicker()
    
    var appointmentBook : [Appointment]?
    var appointmentCall: [[String: Any]] = []
    var appointmentDateArray = [String]()
    var appointmentTimeArray = [String]()
    var visitReasonArray = [String]()
    var doctorNameArray = [String]()
    var addressOfClientArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backImage.image = UIImage(named: "BackgroundImage")
        
        menuButton.setTitle("", for: .normal)
        menuButton.setImage(UIImage(named: "menuImage"), for: .normal)
        
        backButton.setTitle("BACK", for: .normal)
        
        instaPic.image = UIImage(named: "insta")
        instaLink.text = "instagram.com/masriclinic/"
        
        www.image = UIImage(named: "web_link")
        
        wwwLable.text = "www.masriclinic.com/"
        
        
        upcoming.layer.cornerRadius = 5
        lastAppointment.layer.cornerRadius = 5
        
        
        startDateCalender.image = UIImage(named: "DateOfBirthIcon")
        
        
        endDateCalender.image = UIImage(named: "DateOfBirthIcon")
        self.navigationController?.navigationBar.isHidden = true
        let attributedStringForClearButton = NSAttributedString(string: "Clear Filter", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        clearButton.setAttributedTitle(attributedStringForClearButton, for: .normal)
        
        table.register(UINib(nibName: "AppointmentTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        startDate.addTarget(self, action: #selector(dateSetForStart), for: .touchDown)
        endDate.addTarget(self, action: #selector(dateSetForEnd), for: .touchDown)
        
        datePickForStart.preferredDatePickerStyle = .wheels
        datePickForStart.datePickerMode = .date
        datePickForEnd.preferredDatePickerStyle = .wheels
        datePickForEnd.datePickerMode = .date
        
        appointmentCheck()
    }
    
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backToHome(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBOutlet weak var instaPic: UIImageView!
    
    
    @IBOutlet weak var instaLink: UILabel!
    
    
    @IBOutlet weak var www: UIImageView!
    
    @IBOutlet weak var wwwLable: UILabel!
    
    @IBOutlet weak var upcoming: UIButton!
    
    
    @IBOutlet weak var lastAppointment: UIButton!
    
    
    @IBOutlet weak var startDate: UITextField!
    
    @IBOutlet weak var startDateCalender: UIImageView!
    
    @IBOutlet weak var endDate: UITextField!
    
    @IBOutlet weak var endDateCalender: UIImageView!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBAction func clearFilter(_ sender: Any) {
        
        startDate.text = ""
        endDate.text = ""
    }
    
    
    @IBOutlet weak var table: UITableView!
    
    func appointmentCheck()
    {
        ApiManager.shareInstance.callingAppointmentAPI(completionHandler: {
            (comingAppointmentHere) in
            if let result = comingAppointmentHere{
                
                self.appointmentCall = result

            
                for values in result{
                    
                    if let appointmentDate = values["appointment_date"] as? String {
                        self.appointmentDateArray.append(appointmentDate)
                        self.appointmentDateArray.reverse()
                    }
                    if let appointmentTime = values["appointment_time"] as? String {
                        self.appointmentTimeArray.append(appointmentTime)
                        self.appointmentTimeArray.reverse()
                    }
                    if let visitReason = values["visit_reason"] as? String {
                        self.visitReasonArray.append(visitReason)
                        self.visitReasonArray.reverse()
                    }
                    if let doctorName = values["doctor_name"] as? String {
                        self.doctorNameArray.append(doctorName)
                        self.doctorNameArray.reverse()
                    }
                    if let addressOfClient = values["address"] as? String {
                        self.addressOfClientArray.append(addressOfClient)
                        self.addressOfClientArray.reverse()
                    }
                    
                }
                DispatchQueue.main.async{
                    self.table.reloadData()
                }
            }
            else{
                print("Not here")
            }
        })
    }
    
    
    @objc func dateSetForStart(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClickedForStart))
        toolbar.setItems([doneBtn], animated: true)
            
        startDate.inputAccessoryView = toolbar
        startDate.inputView = datePickForStart
    }
    
    @objc func doneClickedForStart(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        startDate.text = formatter.string(from: datePickForStart.date)
        

        
        self.view.endEditing(true)
    }
    
    @objc func dateSetForEnd(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClickedForEnd))
        toolbar.setItems([doneBtn], animated: true)
            
        endDate.inputAccessoryView = toolbar
        endDate.inputView = datePickForEnd
    }
    
    @objc func doneClickedForEnd(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        endDate.text = formatter.string(from: datePickForEnd.date)
        self.view.endEditing(true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentCall.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AppointmentTableViewCell
        
//        let urlAppointmentDate = appointmentCall[indexPath.row]
        cell.dateAndTime.text = appointmentDateArray[indexPath.row]
        cell.time.text = appointmentTimeArray[indexPath.row]
        cell.followUp.text = visitReasonArray[indexPath.row]
        cell.fullName.text = doctorNameArray[indexPath.row]
        cell.addressOfDoctor.text = addressOfClientArray[indexPath.row]
        
        cell.contentView.layer.cornerRadius = 12
        return cell
    }
    
   
}





