//
//  FlickrCollectionViewCell.swift
//  FlickrPhotos
//
//  Created by Henry on 2021/4/6.
//

import UIKit
protocol PassModelDelegate: class {
    func passModel(data: FlickrData)
}

class FlickrCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    private var model: FlickrData?
    private var saveDatas = [FlickrData]()
    weak var delegate: PassModelDelegate?
    
    @IBAction func addBtnPress(_ sender: UIButton) {
        if let data = self.model {
            delegate?.passModel(data: data)
            print("adddddd")
        }
    }
    func updateView(model: FlickrData, mode: VCType) {
        self.titleLabel.text = model.title
        self.model = model
        addBtn.isHidden = mode == .favorite ? true : false
        if let imageURL = URL(string: "https://live.staticflickr.com/\(model.server)/\(model.id)_\(model.secret)_m.jpg") {
            if let data = try? Data(contentsOf: imageURL){
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
}
