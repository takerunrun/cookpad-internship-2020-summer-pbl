//
//  UILabel+Extension.swift
//  DailyCook
//
//  Created by admin on 2020/08/26.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

enum FontStyle: String {
    case black = "NotoSansCJKjp-Black"
    case bold = "NotoSansCJKjp-Bold"
    case regular = "NotoSansCJKjp-Regular"
    case medium = "NotoSansCJKjp-Medium"
}

extension UILabel {

    func apply(fontStyle: FontStyle, size: CGFloat, color: UIColor = Color.textBlack) {
        font = UIFont(name: fontStyle.rawValue, size: size)
        textColor = color
    }
}
