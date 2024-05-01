//
//  PromotionAPI.swift
//  Masri App
//
//  Created by Temp on 25/04/2024.
//

import Foundation
import Alamofire


struct PromotionApiManager{
    static let shareInstance = PromotionApiManager()
    func callingPromotionAPI(completionHandler: @escaping ([Promotions]?) -> Void){
        AF.request(promotion_url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let data):
               if let json = data as? [String: Any],
                  let promotionJSON = json["promotions"] as? [[String: Any]]
                {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: promotionJSON, options: [])
                    
                    let promotions = try JSONDecoder().decode([Promotions].self, from: jsonData)
                    
                    completionHandler(promotions)
                } catch {
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
