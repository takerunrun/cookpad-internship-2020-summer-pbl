//
//  RecipeListCell.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxCocoa

final class RecipeListCell: UICollectionViewCell, View, ViewConstructor {
    
    struct Const {
        static let cellWidth: CGFloat = (DeviceSize.screenWidth - 64) / 2
        static let cellHeight: CGFloat = cellWidth + 48
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 4
    }
    
    private let recipeNumberLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 14)
        $0.textColor = Color.textBlack
    }
    
    private let recipeNameLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 14)
        $0.textColor = Color.textGray
    }
    
    private let borderView = UIView().then {
        $0.layer.borderWidth = 4
        $0.layer.borderColor = Color.teal.cgColor
        $0.layer.cornerRadius = 4
    }
    
    private let lockedNumberLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 20)
        $0.textColor = Color.textBlack
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
        addSubview(imageView)
        addSubview(recipeNumberLabel)
        addSubview(recipeNameLabel)
        
        addSubview(borderView)
        borderView.addSubview(lockedNumberLabel)
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        recipeNumberLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(16)
        }
        recipeNameLabel.snp.makeConstraints {
            $0.top.equalTo(recipeNumberLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(16)
            $0.bottom.equalToSuperview()
        }
        
        borderView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Const.cellWidth)
        }
        lockedNumberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: RecipeListCellReactor) {
        // Action
        
        // State
        reactor.state.map { $0.recipe.imageUrl }
            .distinctUntilChanged()
            .bind { [weak self] imageUrl in
                self?.imageView.setImage(imageUrl: imageUrl)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.recipe.number }
            .distinctUntilChanged()
            .map { "#\(String(format: "%03d", $0))" }
            .bind(to: recipeNumberLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.recipe.name }
            .distinctUntilChanged()
            .bind(to: recipeNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.recipe.number }
            .distinctUntilChanged()
            .map { "#\(String(format: "%03d", $0))" }
            .bind(to: lockedNumberLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.recipe.isCooked }
            .distinctUntilChanged()
            .bind { [weak self] isCooked in
                self?.borderView.isHidden = isCooked
                self?.imageView.isHidden = !isCooked
                self?.recipeNumberLabel.isHidden = !isCooked
                self?.recipeNameLabel.isHidden = !isCooked
            }
            .disposed(by: disposeBag)
    }
}
