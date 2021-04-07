//
//  ResultViewController.swift
//  FlickrPhotos
//
//  Created by Henry on 2021/3/31.
//

import UIKit

enum VCType {
    case search, favorite
}

class ResultViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    private var activityIndicator = UIActivityIndicatorView()
    private var flickrDatas = [FlickrData]()
    private var favoriteDatas = [FlickrData]()
    private var refreshControl : UIRefreshControl!
    private var page = 1
    var type = VCType.search
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name(NotificationCenter_Tab_Reload), object: nil)
        registerCollectionView()
        setRefreshControl()
        apiGetPhoto(page: page)
        showLoadView()
    }
    
    private func registerCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.favoriteDatas = self.getFlickrDatas()
    }
    private func setRefreshControl() {
        if refreshControl == nil {
            refreshControl = UIRefreshControl()
        }
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    @objc private func loadData() {
        page = 1
        apiGetPhoto(page: page)
        self.refreshControl.endRefreshing()
        if tabBarItem.title == "搜尋" {
            SYSTEM.tab = 0
            type = .search
        }else {
            SYSTEM.tab = 1
            type = .favorite
        }
        print("system tab: ", SYSTEM.tab)
    }
    @objc private func reload() {
        self.favoriteDatas = self.getFlickrDatas()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func showLoadView() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        collectionView.addSubview(activityIndicator)
    }
}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SYSTEM.tab {
        case 0:
            return flickrDatas.count
        default:
            return favoriteDatas.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! FlickrCollectionViewCell
        cell.delegate = self
        switch SYSTEM.tab {
        case 0:
            let data = flickrDatas[indexPath.row]
            cell.updateView(model: data, mode: .search)
        default:
            let data = favoriteDatas[indexPath.row]
            cell.updateView(model: data, mode: .favorite)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch SYSTEM.tab {
        case 0:
            let lastElement = flickrDatas.count - 2
            if indexPath.row == lastElement {
                page += 1
                apiGetPhoto(page: page)
            }
        default:
            break
        }
    }
}
extension ResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 2.2
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ResultViewController: PassModelDelegate {
    func passModel(data: FlickrData) {
        favoriteDatas = getFlickrDatas()
        favoriteDatas.append(data)
        saveFlickrDatas(model: favoriteDatas)
    }
}

extension ResultViewController {
    func apiGetPhoto(page: Int) {
        activityIndicator.startAnimating()
        let text = SYSTEM.text
        let count = Int(SYSTEM.count) ?? 0
        NetworkManager.shared.searchFlicker(text: text, perPage: count, page: page) { (result) in
            switch result {
            case .success(let data):
                if page == 1 {
                    self.flickrDatas = data.photos.photo
                } else {
                    self.flickrDatas += data.photos.photo
                }
                self.activityIndicator.stopAnimating()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let err):
                self.activityIndicator.stopAnimating()
                self.presentAlert(title: "", message: err.localizedDescription)
            }
        }
    }
}
