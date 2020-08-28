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
    
    private let grayOverView = UIView().then {
        $0.backgroundColor = Color.textGray.withAlphaComponent(0.7)
    }
    
    private let cookedImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = #imageLiteral(resourceName: "cooked")
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
    
    private let pointTitleLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 13)
        $0.textColor = Color.textBlack
        $0.text = "料理のコツ"
    }
    
    private let pointDescriptionLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 13)
        $0.textColor = Color.textGray
        $0.numberOfLines = 0
    }
    
    let recipeUrlButton = RecipeUrlButton()
    
    private let postImageMessageLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 13)
        $0.textColor = Color.textGray
    }

    let postImageButton = PostImageButton()
    
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
        imageView.addSubview(grayOverView)
        imageView.addSubview(cookedImageView)
        addSubview(recipeNumberLabel)
        addSubview(recipeNameLabel)
        addSubview(flagImageView)
        addSubview(pointTitleLabel)
        addSubview(pointDescriptionLabel)
        addSubview(recipeUrlButton)
        addSubview(postImageMessageLabel)
        addSubview(postImageButton)
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Const.imageViewHeight)
        }
        grayOverView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        cookedImageView.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.size.equalTo(300)
        }
        recipeNumberLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        recipeNameLabel.snp.makeConstraints {
            $0.top.equalTo(recipeNumberLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(16)
        }
        flagImageView.snp.makeConstraints {
            $0.top.equalTo(recipeNameLabel.snp.bottom).offset(32)
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(32)
        }
        pointTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(flagImageView)
            $0.left.equalTo(flagImageView.snp.right).offset(8)
        }
        pointDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(flagImageView.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
        recipeUrlButton.snp.makeConstraints {
            $0.top.equalTo(pointDescriptionLabel.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(32)
        }
        postImageMessageLabel.snp.makeConstraints {
            $0.top.equalTo(recipeUrlButton.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        postImageButton.snp.makeConstraints {
            $0.top.equalTo(postImageMessageLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(200)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: RecipeDetailReactor) {
        // Action
        
        // State
        reactor.state.map { $0.recipe.imageUrl }
            .distinctUntilChanged()
            .bind { [weak self] imageUrl in
                self?.imageView.setImage(imageUrl: imageUrl)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.recipe.isSkipped }
            .distinctUntilChanged()
            .map { !$0 }
            .bind(to: grayOverView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.recipe.isCooked }
            .distinctUntilChanged()
            .map { !$0 }
            .bind(to: cookedImageView.rx.isHidden)
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
        
        reactor.state.map { $0.recipe.point }
            .distinctUntilChanged()
            .bind(to: pointDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.recipe.isCooked }
            .distinctUntilChanged()
            .map { isCooked in
                if isCooked {
                    return "美味しかったらまた今度作ってみよう！"
                } else {
                    // TODO: Replace with next recipe number
                    let number = reactor.currentState.recipe.number + 1
                    return "作って写真をのせると #\(String(format: "%03d", number)) に進めるよ！"
                }
            }
            .bind(to: postImageMessageLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
