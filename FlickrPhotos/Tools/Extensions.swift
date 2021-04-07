//
//  Extensions.swift
//  FlickrPhotos
//
//  Created by Henry on 2021/3/31.
//

import Foundation
import UIKit

public func getVC(storyboardName:String,identifier:String)->UIViewController{
    return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier)
}

//extension UserDefaults {
//    func setCodableObject<T: Codable>(_ data: T?, forKey defaultName: String) {
//        let encoded = try? JSONEncoder().encode(data)
//        set(encoded, forKey: defaultName)
//    }
//    func codableObject<T : Codable>(dataType: T.Type, key: String) -> T? {
//        guard let userDefaultData = data(forKey: key) else {
//          return nil
//        }
//        return try? JSONDecoder().decode(T.self, from: userDefaultData)
//      }
//}
