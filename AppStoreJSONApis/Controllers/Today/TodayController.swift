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
    
    let todayItems = [
        TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", imageName: "garden", description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white),
        TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", imageName: "holiday", description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9813802838, green: 0.9643421769, blue: 0.7214599252, alpha: 1))
    ]
    
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
        return todayItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayCellId, for: indexPath) as! TodayCell
        cell.todayItem = todayItems[indexPath.item]
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
        appFullScreenController?.todayItem = todayItems[indexPath.item]
        let blueView = appFullScreenController!.view!
        blueView.frame = self.startingFrame ?? .zero
        blueView.layer.cornerRadius = 12
//        blueView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissView)))
        self.view.addSubview(blueView)
        self.addChild(self.appFullScreenController!)
        
        appFullScreenController?.dismissHandler = { [weak self] in
            self?.handleDismissView()
        }
        
        collectionView.allowsSelection = false
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut,
                       animations: { [weak self] in
           blueView.frame = self?.view.frame ?? .zero
                        self?.tabBarController?.tabBar.frame.origin.y = self?.view.frame.size.height ?? 0
            guard let cell = self?.appFullScreenController?.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 68
            cell.layoutIfNeeded()
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
            
            guard let cell = self?.appFullScreenController?.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 24
            cell.layoutIfNeeded()
            
            if let tabBarFrame = self?.tabBarController?.tabBar.frame {
                self?.tabBarController?.tabBar.frame.origin.y = (self?.view.frame.size.height ?? 0) - tabBarFrame.height
            }

        } completion: { [weak self] _ in
            viewToDismiss.removeFromSuperview()
            self?.appFullScreenController?.removeFromParent()
            self?.appFullScreenController = nil
            self?.startingFrame = nil
            self?.collectionView.allowsSelection = true
        }
    }
}

extension TodayController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
