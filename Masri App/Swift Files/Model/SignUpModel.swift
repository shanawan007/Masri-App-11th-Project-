//
//  SignUpModel.swift
//  Masri App
//
//  Created by Temp on 15/03/2024.
//

import Foundation


struct Registeration: Encodable{
    let first_name: String
    let last_name: String
    let email: String
    let phone: String
    let password: String
    let gender: String
    let dob: String
    let device_token: String

}
