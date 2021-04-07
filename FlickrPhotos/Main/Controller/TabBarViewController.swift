//
//  TabBarViewController.swift
//  FlickrPhotos
//
//  Created by Henry on 2021/3/31.
//

import UIKit

//protocol ChangeTypeDelegate: class {
//    func changeType(tag: Int)
//}

class TabBarViewController: UITabBarController {

//    weak var changeDelegate: ChangeTypeDelegate?
    var tag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        let resultVC = getVC(storyboardName: "Search", identifier: "resultVC")
        let favoriteVC = getVC(storyboardName: "Search", identifier: "resultVC")
        
        resultVC.tabBarItem = UITabBarItem(title: "搜尋", image: nil, tag: 0)
        favoriteVC.tabBarItem = UITabBarItem(title: "最愛", image: nil, tag: 1)
        
        self.viewControllers = [resultVC, favoriteVC]
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        NotificationCenter.default.post(name: Notification.Name( NotificationCenter_Tab_Reload), object: nil)
        if let tabTitle = item.title {
            if tabTitle == "搜尋" {
                SYSTEM.tab = 0
            } else {
                SYSTEM.tab = 1
            }
            print("system tab: ", SYSTEM.tab)
        }
    }
}
