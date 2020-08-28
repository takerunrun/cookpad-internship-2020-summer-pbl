//
//  SkipButton.swift
//  DailyCook
//
//  Created by admin on 2020/08/28.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SkipButton: UIButton, ViewConstructor {
    // MARK: - Variables
    var isSkipped: Bool = false {
        didSet {
            setStyle(isSkipped: isSkipped)
        }
    }
    
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
        titleLabel?.apply(fontStyle: .bold, size: 12)
        isSkipped = false
        titleLabel?.textAlignment = .center
        layer.masksToBounds = true
        layer.cornerRadius = 8
        
    }
    
    func setupViewConstraints() {}
    
    func setStyle(isSkipped: Bool) {
        if isSkipped {
            setTitle("スキップ中", for: .normal)
            setTitleColor(Color.textBlack, for: .normal)
            backgroundColor = Color.borderGray
        } else {
            setTitle("スキップする", for: .normal)
            setTitleColor(Color.white, for: .normal)
            backgroundColor = Color.teal
        }
    }
    
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

extension Reactive where Base: SkipButton {
    var isSkipped: Binder<Bool> {
        return Binder(base) { view, isSkipped in
            view.isSkipped = isSkipped
        }
    }
}
