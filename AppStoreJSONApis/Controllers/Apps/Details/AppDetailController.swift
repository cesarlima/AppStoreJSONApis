//
//  AppDetail.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 28/04/21.
//  Copyright © 2021 br.com.cesarlima. All rights reserved.
//

import UIKit

class AppDetailController: BaseCollectionViewController {
    let appDetailCellId = "appDetailCellId"
    let previewCellId = "previewCellId"
    var appId:String? {
        didSet {
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, err) in
                let app = result?.results.first
                self.app = app
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var app: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .white
        self.collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: appDetailCellId)
        self.collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.appDetailCellId, for: indexPath) as! AppDetailCell
            cell.app = self.app
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.previewCellId, for: indexPath) as! PreviewCell
        cell.previewScreenshotsController.app = app
        return cell
    }
}

extension AppDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.app = self.app
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            
            return .init(width: view.frame.width, height: estimatedSize.height)
        }
        
        return .init(width: view.frame.width, height: 400)
    }
}
