//
//  ReviewRowCell.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 06/05/21.
//  Copyright © 2021 br.com.cesarlima. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    let reviewsController = ReviewsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        
        addSubview(reviewsController.view)
        reviewsController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
