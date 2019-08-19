//
//  SearchResultCell.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 02/08/19.
//  Copyright © 2019 br.com.cesarlima. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    var appResult: Result! {
        didSet {
            nameLabel.text = appResult.trackName
            categoryLabel.text = appResult.primaryGenreName
            ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
            let icoUrl = URL(string: appResult.artworkUrl100)
            appIconImageView.sd_setImage(with: icoUrl)
            
            screenshot1ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
            
            if appResult.screenshotUrls.count > 1 {
                screenshot2ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
            }
            
            if appResult.screenshotUrls.count > 2 {
                screenshot3ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
            }
        }
    }
    
    let appIconImageView:UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
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
        imv.layer.cornerRadius = 8
        imv.clipsToBounds = true
        imv.layer.borderWidth = 0.5
        imv.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imv.contentMode = .scaleAspectFill
        return imv
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelsStackView = VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
        
        let infoTopStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton])
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
