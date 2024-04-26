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
}
