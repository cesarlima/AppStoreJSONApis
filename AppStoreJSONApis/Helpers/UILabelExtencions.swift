//
//  UILabelExtencions.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 17/08/19.
//  Copyright © 2019 br.com.cesarlima. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text:String, font:UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}
