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
    var originalAppointmentData: [AppointmentRequest] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backImage.image = UIImage(named: "BackgroundImage")
        
        table.delegate = self
        
        table.dataSource = self
        
        menuButton.setTitle("", for: .normal)
        
        menuButton.setImage(UIImage(named: "menuImage"), for: .normal)
        
        backButton.setTitle("BACK", for: .normal)
        
        instaPic.image = UIImage(named: "insta")
        
        www.image = UIImage(named: "web_link")
        
        upcoming.layer.cornerRadius = 5
        
        lastAppointment.layer.cornerRadius = 5
        
        startDateCalender.image = UIImage(named: "DateOfBirthIcon")
        
        endDateCalender.image = UIImage(named: "DateOfBirthIcon")
        
        self.navigationController?.navigationBar.isHidden = true
        
        let attributedStringForClearButton = NSAttributedString(string: "Clear Filter", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        clearButton.setAttributedTitle(attributedStringForClearButton, for: .normal)
        
        table.register(UINib(nibName: "AppointmentTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
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
    
    @IBOutlet weak var www: UIImageView!
    
    @IBOutlet weak var upcoming: UIButton!
    
    @IBOutlet weak var lastAppointment: UIButton!
    
    @IBOutlet weak var startDate: UITextField!
    
    @IBOutlet weak var startDateCalender: UIImageView!
    
    @IBOutlet weak var endDate: UITextField!
    
    @IBOutlet weak var endDateCalender: UIImageView!
    
    @IBOutlet weak var clearButton: UIButton!
    
    func appointmentCheck()
        {
            activityContainer.isHidden = false
            AppointmentApiManager.shareInstance.callingAppointmentAPI(completionHandler: {
                (response) in
                if let found = response {
                    print("Data: \(found)")
//                    self.appointmentModelComing = found
//                    self.originalAppointmentData = found
                }
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
                self.activityContainer.isHidden = true
            })
        }
    
    @IBAction func upcomingAppointmentData(_ sender: Any) {
        
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
    
    
    @IBAction func clearFilterData(_ sender: Any) {
        appointmentModelComing = originalAppointmentData
        
        table.reloadData()
    }
    
    func checkingFilteredArray(){
        
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        guard let startDate = dateFormatter.date(from: startDate.text!),
              let endDate = dateFormatter.date(from: endDate.text!) else{
                return
              }

        let newArray = originalAppointmentData.filter { appointment in
            guard let appointmentDate = dateFormatter.date(from: appointment.appointment_date) else {
                return false
            }
            
            return appointmentDate >= startDate && appointmentDate <= endDate
        }

        appointmentModelComing = newArray
        
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





