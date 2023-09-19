//
//  Urls.swift
//  OZINSHE
//
//  Created by Almat Alibekov on 21.08.2023.
//

import Foundation

class Urls {
        static let BASE_URL = "http://api.ozinshe.com/core/V1/"

        static let SIGN_IN_URL = "http://api.ozinshe.com/auth/V1/signin"
        static let FAVORITE_URL = BASE_URL + "favorite/"
        static let CATEGORIES_URL = BASE_URL + "categories"
        static let SEARCH_MOVIES_URL = BASE_URL + "movies/search"
        static let MOVIES_BY_CATEGORY_URL = BASE_URL + "movies/page"
        static let MAIN_MOVIES_URL = BASE_URL + "movies/main"
        static let GENRES_URL = BASE_URL + "genres"
        static let CATEGORY_AGES_URL = BASE_URL + "category-ages"
        static let MAIN_BANNERS_URL = BASE_URL + "movies_main"
        static let HISTORY_URL = BASE_URL + "history/userHistory"
}
