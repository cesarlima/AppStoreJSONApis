//
//  AppsHeaderCell.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 21/08/19.
//  Copyright © 2019 br.com.cesarlima. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    let companyLabel:UILabel = {
        let lb = UILabel()
        lb.text = "Facebook"
        lb.font = .boldSystemFont(ofSize:12)
        lb.textColor = .blue
        return lb
    }()
    
    let titleLabel:UILabel = {
        let lb = UILabel()
        lb.text = "Keeping up with friends is faster than ever"
        lb.font = .systemFont(ofSize:25)
        lb.numberOfLines = 2
        return lb
    }()
    
    let imageView:UIImageView = {
        let imv = UIImageView(cornerRadius: 8)
        imv.backgroundColor = .red
        return imv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = VerticalStackView(arrangedSubviews: [companyLabel, titleLabel, imageView], spacing: 10)
        
        addSubview(stackView)
        
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
