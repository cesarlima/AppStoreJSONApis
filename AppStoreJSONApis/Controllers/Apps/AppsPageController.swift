//
//  AppsController.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 17/08/19.
//  Copyright © 2019 br.com.cesarlima. All rights reserved.
//

import UIKit

class AppsPageController: BaseCollectionViewController {
    let groupCellId = "groupCellId"
    let headerId = "headerId"
    var groups = [AppGroup]()
    var socialApps = [SocialApp]()
    
    let activityIndicatorView:UIActivityIndicatorView = {
        let aci = UIActivityIndicatorView(style: .whiteLarge)
        aci.color = .darkGray
        aci.startAnimating()
        aci.hidesWhenStopped = true
        return aci
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: self.groupCellId)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerId)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchData()
    }
    
    private func fetchData() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, error) in
            dispatchGroup.leave()
            if let err = error {
                print("Failed to fetch games:", err)
            }
            
            if let group = appGroup {
                self.groups.append(group)
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGrossing { (appGroup, err) in
            dispatchGroup.leave()
            if let err = err {
                print("Failed to fetch grossing:", err)
            }
            
            if let group = appGroup {
                self.groups.append(group)
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchApps { (appGroup, err) in
            dispatchGroup.leave()
            if let err = err {
                print("Failed to fetch apps:", err)
            }
            
            if let group = appGroup {
                self.groups.append(group)
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (apps, err) in
            dispatchGroup.leave()
            if let err = err {
                print("Failed to fetch social apps:", err)
            }
            
            self.socialApps = apps ?? []
        }
        
        
        dispatchGroup.notify(queue: .main) {
            self.collectionView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.headerId, for: indexPath) as! AppsPageHeader
        
        header.appHeaderHorizontalController.socialApps = self.socialApps
        header.appHeaderHorizontalController.collectionView.reloadData()
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.groupCellId, for: indexPath) as! AppsGroupCell
        let app = self.groups[indexPath.item]
        cell.titleLabel.text = app.feed.title
        cell.horizontalController.appsGroup = app
        cell.horizontalController.collectionView.reloadData()
        cell.horizontalController.didSelectHandler = { [weak self] feedResult in
            let detailController = AppDetailController()
            detailController.navigationItem.title = feedResult.name
            detailController.appId = feedResult.id
            self?.navigationController?.pushViewController(detailController, animated: true)
        }
        return cell
    }
}

extension AppsPageController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}

