//
//  SystemConstants.swift
//  FlickrPhotos
//
//  Created by Henry on 2021/3/31.
//

import Foundation

let api_Key = "d6cd43ca7dfc4c6acc40aac858c58ef6"
let NotificationCenter_Tab_Reload = "TABBAR_CHANGE"
let key = "SAVE_DATA"

let base_url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(api_Key)&format=json&nojsoncallback=1&safe_search=1&text=%@&per_page=%ld&page=%ld"

let SYSTEM = SystemManager.shared
