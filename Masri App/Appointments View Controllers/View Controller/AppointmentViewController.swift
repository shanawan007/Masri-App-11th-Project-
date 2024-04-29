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
   
    @IBOutlet weak var table: UITableView!
    
    let datePickForStart = UIDatePicker()
    let datePickForEnd = UIDatePicker()
    
    var appointmentModelComing: [AppointmentRequest] = []
    
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
   
    @IBOutlet weak var activityContainer: UIView!
    
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
    
    @IBAction func clearFilter(val sender: Any) {
        startDate.text = ""
        endDate.text = ""
        
        appointmentCheck()
        DispatchQueue.main.async {
            self.table.reloadData()
        }
        
    }
    
    func appointmentCheck()
        {
            activityContainer.isHidden = false
            AppointmentApiManager.shareInstance.callingAppointmentAPI(completionHandler: {
                (result) in
                if let found = result {
                    
                    for appointment in found{
                        let apiDateFormatter = DateFormatter()
                        apiDateFormatter.dateFormat = "yyyy-MM-dd"

                        let apiDate = apiDateFormatter.date(from: appointment.appointment_date)
                        let displayDateFormatter = DateFormatter()
                        displayDateFormatter.dateFormat = "MMM d, yyyy"
                        let formattedDateString = displayDateFormatter.string(from: apiDate!)
                        self.appointmentModelComing.append(AppointmentRequest(appointment_date: formattedDateString, appointment_time: appointment.appointment_time, visit_reason: appointment.visit_reason, doctor_name: appointment.doctor_name, address: appointment.address))
                    }
                   
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                    }
                self.activityContainer.isHidden = true
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
       
        checkingFilteredArray()
        self.view.endEditing(true)
        
    }
    
    func checkingFilteredArray(){
        
        let startDateText = startDate.text!
        let endDateText = endDate.text!
        if startDateText != "" && endDateText != "" {
            let newArray = appointmentModelComing.filter { appointment in
                return appointment.appointment_date >= startDateText && appointment.appointment_date <= endDateText
            }
            appointmentModelComing = newArray
        }
        table.reloadData()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentModelComing.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AppointmentTableViewCell
        
        if let appointment = appointmentModelComing[indexPath.row] as? AppointmentRequest{
            cell.dateAndTime.text = appointment.appointment_date
            cell.time.text = appointment.appointment_time
            cell.followUp.text = appointment.visit_reason
            cell.fullName.text = appointment.doctor_name
            cell.addressOfDoctor.text = appointment.address
        }
        
        return cell
    }
    
   
}





