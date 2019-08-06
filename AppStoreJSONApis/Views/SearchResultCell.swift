//
//  SearchResultCell.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 02/08/19.
//  Copyright © 2019 br.com.cesarlima. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let nameLabel:UILabel = {
        let lb = UILabel()
        lb.text = "APP NAME"
//        lb.font = .boldSystemFont(ofSize:50)
        return lb
    }()
    
    let categoryLabel:UILabel = {
        let lb = UILabel()
        lb.text = "Photos & Video"
        return lb
    }()
    
    let ratingsLabel:UILabel = {
        let lb = UILabel()
        lb.text = "9.25M"
        return lb
    }()
    
    let getButton:UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("GET", for: .normal)
        bt.setTitleColor(.blue, for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 14)
        bt.backgroundColor = UIColor(white: 0.95, alpha: 1)
        bt.widthAnchor.constraint(equalToConstant: 80).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 32).isActive = true
        bt.layer.cornerRadius = 16
        return bt
    }()
    
    lazy var screenshot1ImageView = self.createScreenshotImageView()
    lazy var screenshot2ImageView = self.createScreenshotImageView()
    lazy var screenshot3ImageView = self.createScreenshotImageView()
    
    func createScreenshotImageView() -> UIImageView {
        let imv = UIImageView()
        imv.backgroundColor = .blue
        return imv
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        
        let labelsStackView = VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
        
        let infoTopStackView = UIStackView(arrangedSubviews: [imageView, labelsStackView, getButton])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        let screenshotStackView = UIStackView(arrangedSubviews: [screenshot1ImageView, screenshot2ImageView, screenshot3ImageView ])
        screenshotStackView.spacing = 12
        screenshotStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, screenshotStackView], spacing: 16)
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
