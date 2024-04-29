//
//  LoginAPI.swift
//  Masri App
//
//  Created by Temp on 25/04/2024.
//

import Foundation
import Alamofire

struct LoginApiManager{
    static let shareInstance = LoginApiManager()
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
}
