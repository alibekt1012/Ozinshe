//
//  BannerMovie.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 19.09.2023.
//

import Foundation
import SwiftyJSON

struct BannerMovie {
    var id = 0
    var link = ""
    var movie = Movie()
    
    init() {
        
    }
    
    init(json: JSON) {
        if let temp = json["id"].int {
            id = temp
        }
        if let temp = json["link"].string {
            link = temp
        }
        if json["movie"].exists() {
            movie = Movie(json: json["movie"])
        }
    }
}
