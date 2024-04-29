//
//  AppointmentAPI.swift
//  Masri App
//
//  Created by Temp on 25/04/2024.
//

import Foundation
import Alamofire

struct AppointmentApiManager{
    static let shareInstance = AppointmentApiManager()
    
    func callingAppointmentAPI(completionHandler: @escaping ([AppointmentRequest]?) -> Void) {
        let userToken = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            .authorization(bearerToken: userToken!),
            .contentType("application/json")
        ]
        
        AF.request(appointment_url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                if let json = data as? [String: Any]
                {
                    let appointmentJSON = json["appointments"] as? [[String: Any]]
                    
                    for appointment in appointmentJSON!{
                        let appointmentDate = appointment["appointment_date"] as? String
                        let appointmentTime = appointment["appointment_time"] as? String
                        let appointmentVisitReason = appointment["visit_reason"] as? String
                        let appointmentDoctorName = appointment["doctor_name"] as? String
                        let appointmentAddress = appointment["address"] as? String
                        
                        let sendResponse:[AppointmentRequest] = [AppointmentRequest(appointment_date: appointmentDate!, appointment_time: appointmentTime!, visit_reason: appointmentVisitReason!, doctor_name: appointmentDoctorName!, address: appointmentAddress!)]
                        completionHandler(sendResponse)
                    }
                }
                else{
                    completionHandler(nil)
                }
            case .failure(_):
                completionHandler(nil)
            }
        }
    }
}

