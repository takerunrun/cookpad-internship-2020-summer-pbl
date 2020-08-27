//
//  RecipeDetailHeaderView.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit

final class RecipeDetailHeaderView: UIView, View, ViewConstructor {
    
    struct Const {
        static let imageViewHeight: CGFloat = 320
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
    }
    
    private let recipeNumberLabel = UILabel().then {
        $0.apply(fontStyle: .black, size: 24)
        $0.textColor = Color.textBlack
        $0.numberOfLines = 0
    }
    
    private let recipeNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 13)
        $0.textColor = Color.textGray
    }
    
    private let flagImageView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "flag").withRenderingMode(.alwaysTemplate)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = Color.textBlack
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
        addSubview(flagImageView)
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Const.imageViewHeight)
        }
        recipeNumberLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        recipeNameLabel.snp.makeConstraints {
            $0.top.equalTo(recipeNumberLabel.snp.bottom).offset(24)
            $0.left.equalToSuperview().inset(16)
        }
        flagImageView.snp.makeConstraints {
            $0.top.equalTo(recipeNameLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(32)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: RecipeDetailReactor) {
        // Action
        
        // State
        reactor.state.map { $0.recipeDetail.imageUrl }
            .distinctUntilChanged()
            .bind { [weak self] imageUrl in
                self?.imageView.setImage(imageUrl: imageUrl)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.recipeDetail.number }
            .distinctUntilChanged()
            .map { "#\($0)" }
            .bind(to: recipeNumberLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.recipeDetail.name }
            .distinctUntilChanged()
            .bind(to: recipeNameLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
