//
//  BaseCollectionViewController.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 17/08/19.
//  Copyright © 2019 br.com.cesarlima. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
