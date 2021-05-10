//
//  TodayCell.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 07/05/21.
//  Copyright © 2021 br.com.cesarlima. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    var topConstraint: NSLayoutConstraint!
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 18))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 26))
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 16), numberOfLines: 3)
    
    var todayItem: TodayItem? {
        didSet {
            guard let item = todayItem else { return }
            categoryLabel.text = item.category
            titleLabel.text = item.title
            imageView.image = UIImage(named: item.imageName)
            descriptionLabel.text = item.description
            backgroundColor = item.backgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 12
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240, height: 240))
        
        let stack = VerticalStackView(arrangedSubviews: [
            categoryLabel, titleLabel, imageContainerView, descriptionLabel
        ], spacing: 8)
        
        addSubview(stack)
        stack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        
        self.topConstraint = stack.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
