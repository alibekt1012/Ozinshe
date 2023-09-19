//
//  Genre.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 11.09.2023.
//

import Foundation
import SwiftyJSON

class Genre {
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
