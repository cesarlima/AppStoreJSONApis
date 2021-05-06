//
//  PreviewCell.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 03/05/21.
//  Copyright © 2021 br.com.cesarlima. All rights reserved.
//

import UIKit

class PreviewCell: UICollectionViewCell {
    let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))
    let previewScreenshotsController = PreviewScreenshotsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        self.backgroundColor = .white
        
        addSubview(previewLabel)
        previewLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        addSubview(previewScreenshotsController.view)
        previewScreenshotsController.view.anchor(top: previewLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    }
}


