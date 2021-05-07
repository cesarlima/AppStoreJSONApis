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
    let reviewCellId = "reviewCellId"
    
    var appId:String? {
        didSet {
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            Service.shared.fetchGenericJSONData(urlString: urlString) {[weak self] (result: SearchResult?, err) in
                let app = result?.results.first
                self?.app = app
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
            let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId ?? "")/sortby=mostrecent/json?en&cc=us"
            Service.shared.fetchGenericJSONData(urlString: reviewsUrl) { [weak self] (reviews: Reviews?, error) in
                if let err = error {
                    print("Failed to decode reviews:", err)
                    return
                }
                self?.reviews = reviews
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    var app: Result?
    var reviews: Reviews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .white
        self.collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: appDetailCellId)
        self.collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        self.collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellId )
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.appDetailCellId, for: indexPath) as! AppDetailCell
            cell.app = self.app
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.previewCellId, for: indexPath) as! PreviewCell
            cell.previewScreenshotsController.app = app
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reviewCellId, for: indexPath) as! ReviewRowCell
        cell.reviewsController.reviews = self.reviews
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
        } else if indexPath.item == 1 {
            return .init(width: view.frame.width, height: 400)
        }
        
        return .init(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
}
