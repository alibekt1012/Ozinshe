//
//  Movie.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 11.08.2023.
//


//  {
//    "id": 109,
//    "movieType": "MOVIE",
//    "name": "Махамбет",
//    "keyWords": "Махамбет батыр",
//    "description": "Махамбет",
//    "year": 2020,
//    "trend": true,
//    "timing": 45,
//    "director": "Қасиет Сақиолла",
//    "producer": "Қасиет Сақиолла",
//    "poster": {
//      "id": 129,
//      "link": "http://api.ozinshe.com/core/public/V1/show/643",
//      "fileId": 643,
//      "movieId": 109
//    },
//    "video": {
//      "id": 365,
//      "link": "Kq0dkn0W0jE",
//      "seasonId": null,
//      "number": 0
//    },
//    "watchCount": 5702,
//    "seasonCount": 0,
//    "seriesCount": 0,
//    "createdDate": "2022-01-31T05:09:15.703+00:00",
//    "lastModifiedDate": "2022-07-14T05:50:03.680+00:00",
//    "screenshots": [
//      {
//        "id": 129,
//        "link": "http://api.ozinshe.com/core/public/V1/show/593",
//        "fileId": 593,
//        "movieId": 109
//      }
//    ],
//    "categoryAges": [
//      {
//        "id": 2,
//        "name": "10-12",
//        "fileId": 257,
//        "link": "http://api.ozinshe.com/core/public/V1/show/257",
//        "movieCount": null
//      },
//      {
//        "id": 1,
//        "name": "8-10",
//        "fileId": 353,
//        "link": "http://api.ozinshe.com/core/public/V1/show/353",
//        "movieCount": null
//      },
//      {
//        "id": 4,
//        "name": "14-16",
//        "fileId": 357,
//        "link": "http://api.ozinshe.com/core/public/V1/show/357",
//        "movieCount": null
//      },
//      {
//        "id": 3,
//        "name": "12-14",
//        "fileId": 356,
//        "link": "http://api.ozinshe.com/core/public/V1/show/356",
//        "movieCount": null
//      }
//    ],
//    "genres": [
//      {
//        "id": 58,
//        "name": "Отбасымен көретіндер",
//        "fileId": 661,
//        "link": "http://api.ozinshe.com/core/public/V1/show/661",
//        "movieCount": null
//      },
//      {
//        "id": 29,
//        "name": "Шытырман оқиғалы",
//        "fileId": 349,
//        "link": "http://api.ozinshe.com/core/public/V1/show/349",
//        "movieCount": null
//      }
//    ],
//    "categories": [
//      {
//        "id": 8,
//        "name": "Толықметрлі мультфильмдер",
//        "fileId": null,
//        "link": null,
//        "movieCount": null
//      }
//    ],
//    "favorite": true
//  }

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


