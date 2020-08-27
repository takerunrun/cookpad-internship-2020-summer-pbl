//
//  RecipeListHeaderView.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class RecipeListHeaderView: UIView, ViewConstructor {
    
    struct Const {
        static let width: CGFloat = DeviceSize.screenWidth - 48
        static let height: CGFloat = width * 304 / 327
    }
    
    // MARK: - Views
    private let todaysAssignmentLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 10)
        $0.textColor = Color.teal
        $0.text = "今日のお題"
    }
    
    private let recipeNumberLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 21)
        $0.textColor = Color.textBlack
    }
    
    private let recipeNameLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 21)
        $0.textColor = Color.gray
    }
    
    private let recipeImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 4
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        setupViewConstraints()
        
        // TODO: Replace with Data from firestore
        setTestData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        addSubview(todaysAssignmentLabel)
        addSubview(recipeNumberLabel)
        addSubview(recipeNameLabel)
        addSubview(recipeImageView)
    }
    
    func setupViewConstraints() {
        todaysAssignmentLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
        }
        recipeNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.right.left.equalToSuperview()
            $0.height.equalTo(24)
        }
        recipeNameLabel.snp.makeConstraints {
            $0.top.equalTo(recipeNumberLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(24)
        }
        recipeImageView.snp.makeConstraints {
            $0.top.equalTo(recipeNameLabel.snp.bottom).offset(8)
            $0.right.left.bottom.equalToSuperview()
        }
    }
    
    func setTestData() {
        recipeNumberLabel.text = "#005"
        recipeNameLabel.text = "やみつきキャベツ"
        recipeImageView.setImage(imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/06/IMG_3529-768x512.jpg")
    }
}
