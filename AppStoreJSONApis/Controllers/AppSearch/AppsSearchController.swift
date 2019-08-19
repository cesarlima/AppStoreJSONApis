//
//  AppsSearchController.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 02/08/19.
//  Copyright © 2019 br.com.cesarlima. All rights reserved.
//

import UIKit
import SDWebImage

class AppsSearchController: BaseCollectionViewController, UISearchBarDelegate {
    fileprivate let cellId = "CellSearchResult"
    fileprivate var appResults = [Result]()
    fileprivate let searchBarController:UISearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBarController.searchBar.delegate = self
    }
    
    fileprivate func fetchItunesApps() {
        Service.shared.fetchApps(searchTerm: "Twitter") { (results, err) in
            
            if let err = err {
                print("Error to fetch apps:", err)
                return
            }
            
            self.appResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        let searchTerm = searchBar.text ?? ""

        Service.shared.fetchApps(searchTerm: searchTerm) { (results, err) in

            if let err = err {
                print("Error to fetch apps:", err)
                return
            }

            self.appResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
//
//        Service.shared.fetchApps(searchTerm: searchText) { (results, err) in
//
//            if let err = err {
//                print("Error to fetch apps:", err)
//                return
//            }
//
//            self.appResults = results
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.appResult = appResults[indexPath.item]
        return cell
    }
}

extension AppsSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
}
