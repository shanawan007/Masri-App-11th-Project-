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
    func callingPromotionAPI(completionHandler: @escaping ([PromotionModel]?) -> Void){
        AF.request(promotion_url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let data):
                if let json = data as? [String: Any]
                {
                    let promotionJSON = json["promotions"] as? [[String: Any]]
                    var imageURL = "https://masriapi.ssasoft.com/"
                    for promotion in promotionJSON!{
                        let images = promotion["image"] as? String
                        let sentPromotion: [PromotionModel] = [PromotionModel(imageURL: imageURL + images!)]
                        completionHandler(sentPromotion)
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
