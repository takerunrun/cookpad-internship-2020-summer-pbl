//
//  RecipeDetailCookedRecipeCell.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit

final class RecipeDetailCookedRecipeCell: UICollectionViewCell, View, ViewConstructor {
    
    struct Const {
        static let cellWidth: CGFloat = DeviceSize.screenWidth
        static let cellHeight: CGFloat = cellWidth + 32
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let dateLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 14)
        $0.textColor = Color.teal
    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 4
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        addSubview(dateLabel)
        addSubview(imageView)
    }
    
    func setupViewConstraints() {
        dateLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.top.right.equalToSuperview()
            $0.height.equalTo(32)
        }
        imageView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: RecipeDetailCookedRecipeReactor) {
        // Action
        
        // State
        reactor.state.map { $0.cookedRecipe.date }
            .distinctUntilChanged()
            .map { "\($0)" }
            .bind(to: dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.cookedRecipe.imageUrl }
            .distinctUntilChanged()
            .bind { [weak self] imageUrl in
                self?.imageView.setImage(imageUrl: imageUrl)
            }
            .disposed(by: disposeBag)
    }
}
