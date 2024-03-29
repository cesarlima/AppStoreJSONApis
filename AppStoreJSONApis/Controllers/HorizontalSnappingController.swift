//
//  HorizontalSnappingController.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 05/09/19.
//  Copyright © 2019 br.com.cesarlima. All rights reserved.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {
    
    init() {
        let layout = BetterSnappingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SnappingLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        let itemWidth = collectionView.frame.width - 48
        let itemSpace = itemWidth + minimumInteritemSpacing
        var pageNumber = round(collectionView.contentOffset.x / itemSpace)
        
        let velocityX = velocity.x
        
        if velocityX > 0 {
            pageNumber += 1
        } else if velocityX < 0 {
            pageNumber -= 1
        }
        let nearestPageOffset = pageNumber * itemSpace
        
        return CGPoint(x: nearestPageOffset, y: parent.y)
    }
}
