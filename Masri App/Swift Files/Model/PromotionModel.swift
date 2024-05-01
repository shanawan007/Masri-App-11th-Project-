//
//  PromotionModel.swift
//  Masri App
//
//  Created by Temp on 26/03/2024.
//

import Foundation

struct Promotions: Decodable{
   var id: String
   var title: String
   var details: String
   var image: String
   var start_date: String
   var end_date: String
   var status: String
   var created_at: String
}
