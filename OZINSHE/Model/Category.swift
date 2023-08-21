//
//  Category.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 21.08.2023.
//


//{
//    "id": 1,
//    "name": "ÖZINŞE–де танымал",
//    "fileId": null,
//    "link": "http://api.ozinshe.com/core/public/V1/show/null",
//    "movieCount": 16
//  }

import Foundation
import SwiftyJSON

class Category {
    var id = 0
    var name = ""
    var link = ""
    
    init(json: JSON) {
        if let temp = json["id"].int {
            id = temp
        }
        if let temp = json["name"].string {
            name = temp
        }
        if let temp = json["link"].string {
            link = temp
        }
    }
}
