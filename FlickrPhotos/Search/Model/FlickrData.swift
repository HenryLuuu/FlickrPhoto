//
//  FlickrData.swift
//  FlickrPhotos
//
//  Created by Henry on 2021/3/31.
//

import Foundation

class FlickrData: NSObject, NSCoding, Codable {
    
    let id: String
    let secret: String
    let server: String
//    let farm: Int
    let title: String

//    var imageURL: URL {
//        return URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
//    }
    init(title :String, id: String, server: String, secret: String) {
        self.title = title
        self.id = id
        self.secret = server
        self.server = server
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "TITLE")
        coder.encode(id, forKey: "ID")
        coder.encode(secret, forKey: "SECRET")
        coder.encode(server, forKey: "SERVER")
    }

    required init?(coder: NSCoder) {
        self.title = coder.decodeObject(forKey: "TITLE") as! String
        self.id = coder.decodeObject(forKey: "ID") as! String
        self.secret = coder.decodeObject(forKey: "SECRET") as! String
        self.server = coder.decodeObject(forKey: "SERVER") as! String
        
    }
}

struct PhotoData: Codable {

    let photo: [FlickrData]

}

struct SearchData: Codable {

    let photos: PhotoData

}
