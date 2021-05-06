//
//  PreviewSnappingController.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 04/05/21.
//  Copyright © 2021 br.com.cesarlima. All rights reserved.
//

import UIKit

class PreviewScreenshotsController: HorizontalSnappingController {
    let previewSnapshotCellId = "previewSnapshotCellId"
    var app: Result? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .white
        self.collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: previewSnapshotCellId)
        self.collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.previewSnapshotCellId, for: indexPath) as! ScreenshotCell
        let screenshotURL = self.app?.screenshotUrls[indexPath.item] ?? ""
        cell.imageView.sd_setImage(with: URL(string: screenshotURL))
        return cell
    }
}

extension PreviewScreenshotsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 200, height: view.frame.height)
    }
}

class ScreenshotCell: UICollectionViewCell {
    let imageView = UIImageView(cornerRadius: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
