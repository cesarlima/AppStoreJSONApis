//
//  AppsHeaderHorizontalController.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 21/08/19.
//  Copyright © 2019 br.com.cesarlima. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: HorizontalSnappingController {
    private let cellId = "cellId"
    var socialApps = [SocialApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: self.cellId)
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.socialApps.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! AppsHeaderCell
        let app = self.socialApps[indexPath.item]
        
        cell.companyLabel.text = app.name
        cell.titleLabel.text = app.tagline
        cell.imageView.sd_setImage(with: URL(string: app.imageUrl))

        return cell
    }
}

extension AppsHeaderHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 40, height: view.frame.height)
    }
}
