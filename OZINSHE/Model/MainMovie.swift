//
//  MainMovies.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 08.09.2023.
//

import Foundation
import SwiftyJSON

struct MainMovie {
    var categoryId = 0
    var categoryName = ""
    var movies: [Movie] = []
    
    init() {
        
    }
    
    init(json: JSON) {
        if let temp = json["categoryId"].int {
            categoryId = temp
        }
        if let temp = json["categoryName"].string {
            categoryName = temp
        }
        if let array = json["movies"].array {
            for item in array {
                let temp = Movie(json: item)
                movies.append(temp)
            }
        }
    }
}
