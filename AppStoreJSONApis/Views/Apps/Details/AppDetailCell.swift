//
//  AppDetailCell.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 29/04/21.
//  Copyright © 2021 br.com.cesarlima. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    
    var app: Result! {
        didSet {
            guard let app = app else { return }
            nameLabel.text = app.trackName
            releaseNotesLabel.text = app.releaseNotes
            priceButton.setTitle(app.formattedPrice, for: .normal)
            appIconImageView.sd_setImage(with: URL(string: app.artworkUrl100))
        }
    }
    
    let appIconImageView = UIImageView(cornerRadius: 16)
    let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    let priceButton = UIButton(title: "$4.99")
    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
    let releaseNotesLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        appIconImageView.backgroundColor = .blue
        appIconImageView.constrainWidth(constant: 140)
        appIconImageView.constrainHeight(constant: 140)
        priceButton.backgroundColor = #colorLiteral(red: 0.1961007714, green: 0.473749578, blue: 0.9349606633, alpha: 1)
        priceButton.setTitleColor(.white, for: .normal)
        priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        priceButton.constrainHeight(constant: 32)
        priceButton.layer.cornerRadius = 32 / 2
        priceButton.constrainWidth(constant: 80)
        let vWithButton = UIView()
        vWithButton.backgroundColor = .systemPink
        let vWithLabel = UIView()
        vWithLabel.backgroundColor = .purple
        let stack = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                appIconImageView,
                VerticalStackView(arrangedSubviews: [
                    nameLabel,
                    UIStackView(arrangedSubviews: [
                        priceButton,
                        vWithButton
                    ]),
                    vWithLabel
                ], spacing: 12),
            ], customSpacing: 20),
            whatsNewLabel,
           releaseNotesLabel
        ], spacing: 16)
        
        self.contentView.addSubview(stack)
        stack.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
