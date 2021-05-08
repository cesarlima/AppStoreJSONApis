//
//  TodayCell.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 07/05/21.
//  Copyright © 2021 br.com.cesarlima. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 12
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.centerInSuperview(size: .init(width: 230, height: 230))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
