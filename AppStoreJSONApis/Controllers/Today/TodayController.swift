//
//  TodayController.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 07/05/21.
//  Copyright © 2021 br.com.cesarlima. All rights reserved.
//

import UIKit

class TodayController: BaseCollectionViewController {
    let todayCellId = "todayCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = #colorLiteral(red: 0.9489166141, green: 0.9490789771, blue: 0.9489063621, alpha: 1)
        self.collectionView.register(TodayCell.self, forCellWithReuseIdentifier: todayCellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayCellId, for: indexPath) as! TodayCell
        
        return cell
    }
    var startingFrame: CGRect?
    var appFullScreenController: AppFullsreenController?
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        appFullScreenController = AppFullsreenController()
        let blueView = appFullScreenController!.view!
        blueView.frame = self.startingFrame ?? .zero
        blueView.layer.cornerRadius = 12
//        blueView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissView)))
        self.view.addSubview(blueView)
        self.addChild(self.appFullScreenController!)
        
        appFullScreenController?.dismissHandler = { [weak self] in
            self?.handleDismissView()
        }
        
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut,
                       animations: { [weak self] in
           blueView.frame = self?.view.frame ?? .zero
           self?.tabBarController?.tabBar.isHidden = true
        }, completion: nil)
    }
    
    @objc func handleDismissView() {
        guard let viewToDismiss = self.appFullScreenController?.view else { return }
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) { [weak self] in
            
            viewToDismiss.frame = self?.startingFrame ?? .zero
            self?.appFullScreenController?.tableView.contentOffset = .zero
            self?.tabBarController?.tabBar.isHidden = false
        } completion: { [weak self] _ in
            viewToDismiss.removeFromSuperview()
            self?.appFullScreenController?.removeFromParent()
            self?.appFullScreenController = nil
            self?.startingFrame = nil
        }
    }
}

extension TodayController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 300, height: 330)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
