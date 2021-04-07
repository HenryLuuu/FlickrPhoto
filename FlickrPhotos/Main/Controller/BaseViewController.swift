//
//  BaseViewController.swift
//  FlickrPhotos
//
//  Created by Henry on 2021/3/31.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    func setNavigetionBar(navigationController: UINavigationController?, navigationItem: UINavigationItem?, title: String? = nil) {
        
        if let naviController = navigationController {
            naviController.navigationBar.barTintColor = .white
            if let naviTitle = title {
                self.navigationItem.title = naviTitle
            }
        }
    }
    func presentAlert(title: String? = nil, message: String? = nil, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default) {_ in
            guard let completion = completion else { return }
            completion()
        }
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func saveFlickrDatas(model: [FlickrData]) {
        let saveData = try!NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: false)
        UserDefaults.standard.set(saveData, forKey: key)
    }
    
    func getFlickrDatas() -> [FlickrData]{
        var datas = [FlickrData]()
        if let getData = UserDefaults.standard.object(forKey: key) as? NSData {
            datas = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(getData as Data) as! [FlickrData]
        }
        return datas
    }
}

