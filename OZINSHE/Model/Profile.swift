//
//  Profile.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 12.08.2023.
//
//{
//  "id": 35,
//  "user": {
//    "id": 38,
//    "email": "qwerty@mail.ru"
//  },
//  "name": "Азамат",
//  "phoneNumber": "+7 (245) 556-66-88",
//  "birthDate": "2023-08-22",
//  "language": "kaz"
//}
//

import Foundation
import SwiftyJSON

struct Profile {
    
    var id = 0
    var user_email = "qwe"
    var name = ""
    var phoneNumber = ""
    var birthDate = ""
    var language = ""
    
    init() {
        
    }

    init(json: JSON) {
        if let temp = json["id"].int {
            id = temp
        }
        
        if json["user"].exists() {
            if let temp = json["user"]["email"].string {
                user_email = temp
            }
        }
        if let temp = json["name"].string {
            name = temp
        }
        if let temp = json["phoneNumber"].string {
            phoneNumber = temp
        }
        if let temp = json["birthDate"].string {
            birthDate = temp
        }
        if let temp = json["language"].string {
            language = temp
        }
    }

    
}

