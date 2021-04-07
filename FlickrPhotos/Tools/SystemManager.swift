//
//  SystemManager.swift
//  FlickrPhotos
//
//  Created by Henry on 2021/4/6.
//

import Foundation

class SystemManager: NSObject {
    
    static let shared = SystemManager()
    private override init() {
        print("init SYSTEM Manager")
    }
    
    deinit {}

    var text: String {
        set {
            UserDefaults.standard.set(newValue,forKey:"TEXT")
        } get {
            guard let t = UserDefaults.standard.string(forKey:"TEXT") else {
                return ""
            }
            return t
        }
    }
    
    var count: String {
        set {
            UserDefaults.standard.set(newValue,forKey:"COUNT")
        } get {
            guard let t = UserDefaults.standard.string(forKey:"COUNT") else {
                return ""
            }
            return t
        }
    }
    
    var tab: Int {
        set {
            UserDefaults.standard.set(newValue,forKey:"TAB")
        } get {
            let t = UserDefaults.standard.integer(forKey:"TAB")
            return t
        }
    }
}
