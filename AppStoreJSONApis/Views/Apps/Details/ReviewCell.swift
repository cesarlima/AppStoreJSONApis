//
//  ReviewCell.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 06/05/21.
//  Copyright © 2021 br.com.cesarlima. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 16))
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    let bodyLabel = UILabel(text: "Review body\nReview body\nReviw Body", font: .systemFont(ofSize: 14), numberOfLines: 6)
    let stackViewStars: UIStackView = {
        var subViews = [UIView]()
        for _ in 0...5 {
            let imgStar = UIImageView(image: UIImage(named: "star"))
            imgStar.constrainWidth(constant: 24)
            imgStar.constrainHeight(constant: 24)
            subViews.append(imgStar)
        }
        subViews.append(UIView())
        return UIStackView(arrangedSubviews: subViews)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9450011849, green: 0.9406232238, blue: 0.9736520648, alpha: 1)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                titleLabel, authorLabel
            ], customSpacing: 8),
            stackViewStars,
            bodyLabel
        ], spacing: 12)
        authorLabel.textAlignment = .right
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(stackView)
        stackView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(review:Entry?) {
        guard let review = review else { return }
        self.titleLabel.text = review.title.label
        self.authorLabel.text = review.author.name.label
        self.bodyLabel.text = review.content.label
        
        if let rating = Int(review.rating.label) {
            for (index, view) in self.stackViewStars.arrangedSubviews.enumerated() {
                view.alpha = index >= rating ? 0 : 1
            }
        }
    }
}
