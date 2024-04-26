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
    
    func callingAppointmentAPI(completionHandler: @escaping ([[String:Any]]?) -> Void) {
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
                    completionHandler(appointmentJSON)
                }
            case .failure(_):
                completionHandler(nil)
            }
        }
    }
}

