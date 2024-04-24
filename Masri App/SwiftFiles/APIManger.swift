//
//  APIManger.swift
//  Masri App
//
//  Created by Temp on 15/03/2024.
//

import Foundation
import Alamofire

enum ApiErrors: Error{
    case custom(message: String)
    
}

typealias Handler = (Swift.Result<Any?, ApiErrors>) -> Void
struct ApiManager{
    static let shareInstance = ApiManager()
    
    func callingRegisterAPI(register: Registeration, completion: @escaping (Bool)-> Void){
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(register_url, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
                
            case .success(let data):
                do{
                    guard let json = try? JSONSerialization.jsonObject(with: data!) as? [String:Any] else {
                        completion(false)
                        return
                    }
                    print("here is my status code \(response.response?.statusCode)")
                    if let success = json["success"] as? Bool{
                        completion(success)
                    }
                    else{
                        completion(false)
                    }
                    //                    completion("I am successfull")
                    
                } catch {
                    print("Result: \(response)")
                    completion(false)
                }
            case .failure(_):
                completion(false)
            }
            
        }
    }
    func callingLoginAPI(login: LoginModel, completionHandler: @escaping (Bool)->()) {
        print("Login is \(login)")
        let headers: HTTPHeaders = [
            
            .init(name: "Accept", value: "application/json")
            
        ]
        
        AF.request(login_url, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        if let jsonObject = json as? [String: Any], let token = jsonObject["token"] as? String, let success = jsonObject["success"] as? Bool {
                            UserDefaults.standard.set(token, forKey: "token")
                            
                            print("Token No: \(token)")
                            completionHandler(success)
                        }
                        else{
                            completionHandler(false)
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                        completionHandler(false)
                        
                    }
                } else {
                    completionHandler(false)
                    
                }
            case .failure(let err):
                completionHandler(false)
            default:
                print("Can't be saved")
            }
        }
    }
    func callingForgetAPI(forget: ForgetModel, completionHandler: @escaping (Bool)-> Void){
        
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        AF.request(forget_url, method: .post, parameters: forget, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any]
                    if let jsonObject = json as? [String: Any], let password = jsonObject["password"] as? String{
                        completionHandler(true)
                    }
                    else{
                        completionHandler(false)
                    }
                } catch {
                    completionHandler(false)
                    return
                }
            case .failure(_):
                completionHandler(false)
            }
            
        }
    }
    func callingPromotionAPI(completionHandler: @escaping ([String]?) -> Void){
        AF.request(promotion_url, method: .get).responseJSON { response in
            switch response.result {
            case .success(let data):
                if let json = data as? [String: Any]
                {
                    let promotionJSON = json["promotions"] as? [[String: Any]]
                    var imageURL = [String]()
                    for promotion in promotionJSON!{
                        if let imagesURL = promotion["image"] as? String {
                            imageURL.append(imagesURL)
                        }
                        completionHandler(imageURL)
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

//var appointmentURL = [String]()
//for appointmentIndex in appointmentJSON!{
//    if let dateComing = appointmentIndex["appointment_date"] as? String {
//        appointmentURL.append(dateComing)
//    }
//}
//    if let timeComing = appointmentIndex["appointment_time"] as? String {
//        appointmentURL.append(timeComing)
//    }
//    if let visitComing = appointmentIndex["visit_reason"] as? String {
//        appointmentURL.append(visitComing)
//    }
//    if let doctorComing = appointmentIndex["doctor_name"] as? String {
//        appointmentURL.append(doctorComing)
//    }
//    if let addressComing = appointmentIndex["address"] as? String {
//        appointmentURL.append(addressComing)
//    }
//}
//
//guard let firstName = appointmentJSON["first_name"] as? String else { return }
//guard let lastName = appointmentJSON["last_name"] as? String else { return }
//guard let emailOfClient = appointmentJSON["email"] as? String else { return }
//guard let phoneNumber = appointmentJSON["phone"] as? String else { return }
//guard let dateOfBirth = appointmentJSON["dob"] as? String else { return }
//guard let genderSelect = appointmentJSON["gender"] as? String else { return }
//guard let idNumber = appointmentJSON["id"] as? String else { return }
//guard let userIdNumber = appointmentJSON["user_id"] as? String else { return }
//guard let typeIdNumber = appointmentJSON["type_id"] as? String else { return }
//guard let locationIdNumber = appointmentJSON["location_id"] as? String else { return }
//guard let appointDate = appointmentJSON["appointment_date"] as? String else { return }
//guard let appointTime = appointmentJSON["appointment_time"] as? String else { return }
//guard let visitReason = appointmentJSON["visit_reason"] as? String else { return }
//guard let visitBefore = appointmentJSON["visited_before"] as? String else { return }
//guard let providerName = appointmentJSON["provider_name"] as? String else { return }
//guard let paidVia = appointmentJSON["paid_via"] as? String else { return }
//guard let createdBy = appointmentJSON["created_by"] as? String else { return }
//guard let visitType = appointmentJSON["visit_type"] as? String else { return }
//guard let doctorName = appointmentJSON["doctor_name"] as? String else { return }
//guard let addressDoctor = appointmentJSON["address"] as? String else {return}
