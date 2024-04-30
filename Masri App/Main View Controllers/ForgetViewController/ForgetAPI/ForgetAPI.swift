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
        AF.request(forget_url, method: .post, parameters: forget, encoder: JSONParameterEncoder.default, headers: headers).responseJSON { response in
            debugPrint(response)
            switch response.result{
                
            case .success(_):
                return completionHandler(true)
            case .failure(_):
                return completionHandler(false)
            }
            
        }
    }
}
