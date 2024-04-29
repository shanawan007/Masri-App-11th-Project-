//
//  ForgetAPI.swift
//  Masri App
//
//  Created by Temp on 25/04/2024.
//

import Foundation
import Alamofire

struct ForgetApiManager{
    static let shareInstance = ForgetApiManager()
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
}
