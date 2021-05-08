//
//  AppFullscreenHeaderCell.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 08/05/21.
//  Copyright © 2021 br.com.cesarlima. All rights reserved.
//

import UIKit

class AppFullscreenHeaderCell: UITableViewCell {
    let todayCell = TodayCell()
    var dismissHandler: (() -> Void)?
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpView() {
        addSubview(todayCell)
        todayCell.fillSuperview()
        
        contentView.addSubview(closeButton)
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 38))
        closeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
    }
    
    @objc private func dismiss() {
        self.dismissHandler?()
    }
}
