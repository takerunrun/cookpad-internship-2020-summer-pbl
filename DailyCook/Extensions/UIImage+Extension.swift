//
//  UIImage+Extension.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String, placeholder: UIImage = #imageLiteral(resourceName: "noimage")) {
        guard let url = URL(string: imageUrl) else {
            self.image = placeholder
            return
        }
        
        kf.setImage(with: url, placeholder: placeholder)
    }
}
