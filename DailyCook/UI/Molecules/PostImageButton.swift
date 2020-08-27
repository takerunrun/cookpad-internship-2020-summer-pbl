//
//  PostImageButton.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//
import UIKit

final class PostImageButton: UIButton, ViewConstructor {
    // MARK: - Variables
    
    override var isHighlighted: Bool {
        didSet {
            shrink(down: isHighlighted)
        }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = Color.lightGray.cgColor
        
        setImage(#imageLiteral(resourceName: "dish"), for: .normal)
    }
    
    func setupViewConstraints() {}
    
    func shrink(down: Bool) {
        UIView.animate(withDuration: 0.1,
                       delay: 0.0,
                       options: [.allowUserInteraction],
                       animations: {
            if down {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            } else {
                self.transform = .identity
            }
        },
        completion: nil)
    }
}
