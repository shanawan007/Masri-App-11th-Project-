//
//  appointmentBook.swift
//  Masri App
//
//  Created by Temp on 21/03/2024.
//

import Foundation

struct AppointmentResponse: Encodable{
    var first_name: String
    var last_name: String
    var email: String
    var phone: String
    var dob: String
    var gender: String
    var id: String
    var user_id: String
    var type_id: String
    var location_id: String
    var appointment_date: String
    var appointment_time: String
    var visit_reason: String
    var visited_before: String
    var provider_name: String
    var paid_via: String
    var created_by: String
    var visit_type: String
    var doctor_name: String
    var address: String    
}


struct AppointmentRequest: Encodable{
    
    var appointment_date: String
    var appointment_time: String
    var visit_reason: String
    var doctor_name: String
    var address: String
    
    init(appointment_date: String, appointment_time: String, visit_reason: String, doctor_name: String, address: String) {
        self.appointment_date = appointment_date
        self.appointment_time = appointment_time
        self.visit_reason = visit_reason
        self.doctor_name = doctor_name
        self.address = address
    }
}



