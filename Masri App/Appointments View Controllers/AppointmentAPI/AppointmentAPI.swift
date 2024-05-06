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
                if let json = data as? [String: Any],
                   let appointmentJSON = json["appointments"] as? [String: Any]{
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: appointmentJSON, options: [])
                        let appointments = try JSONDecoder().decode([AppointmentRequest].self, from: jsonData)
                        completionHandler(appointments)
                        
                    }
                    catch {
                        print("Error decoding JSON: \(error)")
                        completionHandler(nil)
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

