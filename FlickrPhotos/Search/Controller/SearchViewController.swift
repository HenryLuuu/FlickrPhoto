//
//  ViewController.swift
//  FlickrPhotos
//
//  Created by Henry on 2021/3/23.
//

import UIKit
import Foundation

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var contentTxf: UITextField!
    @IBOutlet weak var countTxf: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigetionBar(navigationController: self.navigationController, navigationItem: self.navigationItem, title: "搜尋輸入頁")
        
        initUI()
    }

    @IBAction func searchBtnPressed(_ sender: UIButton) {
        if checkInput() == false {return}
        let tabBarVC = getVC(storyboardName: "Main", identifier: "tabbarVC")
        guard let text = contentTxf.text else {return}
        guard let count = countTxf.text else {return}
        SYSTEM.text = text
        SYSTEM.count = count
        SYSTEM.tab = 0
        self.navigationController?.pushViewController(tabBarVC, animated: true)
    }
    
    func initUI() {
        contentTxf.placeholder = "欲搜尋內容"
        countTxf.placeholder = "每頁呈現數量"
        
        countTxf.keyboardType = .numberPad
        
        searchBtn.setTitle("搜尋", for: .normal)
        searchBtn.backgroundColor = .gray
        searchBtn.setTitleColor(.white, for: .normal)
        searchBtn.isEnabled = false
        
        contentTxf.addTarget(self, action: #selector(checkEmpty), for: .editingChanged)
        countTxf.addTarget(self, action: #selector(checkEmpty), for: .editingChanged)
    }
    func checkInput() -> Bool {
        if contentTxf.text?.isEmpty == true {
            return false
        }
        if countTxf.text?.isEmpty == true {
            return false
        }
        return true
    }
    @objc func checkEmpty() {
        if checkInput() == true {
            searchBtn.backgroundColor = .blue
            searchBtn.isEnabled = true
        } else {
            searchBtn.backgroundColor = .gray
            searchBtn.isEnabled = false
        }
    }
}
