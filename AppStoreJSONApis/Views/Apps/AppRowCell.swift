//
//  AppRrowCell.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 19/08/19.
//  Copyright © 2019 br.com.cesarlima. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}

class AppRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    let getButton = UIButton(title: "GET")
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        imageView.backgroundColor = .green
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        
        getButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.layer.cornerRadius = 32 / 2
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        let stackLabels = VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, stackLabels, getButton])
        stackView.alignment = .center
        stackView.spacing = 16
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
}
