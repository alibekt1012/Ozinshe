//
//  Movie.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 11.08.2023.
//

import Foundation
import SwiftyJSON

struct Movie {
    var id = 0
    var movieType = ""
    var name = ""
    var keyWord = ""
    var description = ""
    var year = 0
    var trend = false
    var timing = 0
    var director = ""
    var producer = ""
    var poster_link = ""
    var video_link = ""
    var watchCount = 0
    var seasonCount = 0
    var seriesCount = 0
    var createdDate = ""
    var lastModifiedDate = ""
    var favorite = false
    
    init() {
        
    }
    
    init(json: JSON) {
        if let temp = json["id"].int {
            id = temp
        }
        if let temp = json["movieType"].string {
            movieType = temp
        }
        if let temp = json["name"].string {
            name = temp
        }
        if let temp = json["keyWord"].string {
            keyWord = temp
        }
        if let temp = json["description"].string {
            description = temp
        }
        if let temp = json["year"].int {
            year = temp
        }
        if let temp = json["trend"].bool {
            trend = temp
        }
        if let temp = json["timing"].int {
            timing = temp
        }
        if let temp = json["director"].string {
            director = temp
        }
        if let temp = json["producer"].string {
            producer = temp
        }
        if json["poster"].exists() {
            if let temp = json["poster"]["link"].string {
                poster_link = temp
            }
        }
        if json["video"].exists() {
            if let temp = json["video"]["link"].string {
                video_link = temp
            }
        }
        if let temp = json["watchCount"].int {
            watchCount = temp
        }
        if let temp = json["seasonCount"].int {
            seasonCount = temp
        }
        if let temp = json["seriesCount"].int {
            seriesCount = temp
        }
        if let temp = json["createdDate"].string {
            createdDate = temp
        }
        if let temp = json["lastModifiedDate"].string {
            lastModifiedDate = temp
        }
        if let temp = json["favorite"].bool {
            favorite = temp
        }
        
    }
}


