//
//  SignupAPI.swift
//  Masri App
//
//  Created by Temp on 25/04/2024.
//

import Foundation
import Alamofire

struct SignupApiManager{
    static let shareInstance = SignupApiManager()
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
}
