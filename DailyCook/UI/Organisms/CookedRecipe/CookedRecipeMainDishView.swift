//
//  CookedRecipeMainDishView.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReusableKit
import ReactorKit

final class CookedRecipeMainDishView: UIView, View, ViewConstructor {
    
    private struct Const {
        static let height: CGFloat = 56 + RecipeListCell.Const.cellHeight
        static let width: CGFloat = DeviceSize.screenWidth
        static let collectionViewContentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        static let minimumLineSpacing: CGFloat = 12
        static let itemSize: CGSize = RecipeListCell.Const.itemSize
    }
    
    struct Reusable {
        static let recipeCell = ReusableCell<RecipeListCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: Const.width, height: Const.height)
    }
    
    // MARK: - Views
    private let titleLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 20)
        $0.textColor = Color.textBlack
        $0.text = "主菜"
    }
    
    let showAllButton = UIButton().then {
        $0.titleLabel?.apply(fontStyle: .regular, size: 16)
        $0.setTitle("すべて見る", for: .normal)
        $0.setTitleColor(Color.textBlack, for: .normal)
        $0.setTitleColor(Color.lightGray, for: .highlighted)
        $0.titleEdgeInsets.bottom = 0
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = Const.itemSize
        $0.minimumLineSpacing = Const.minimumLineSpacing
        $0.scrollDirection = .horizontal
    }).then {
        $0.register(Reusable.recipeCell)
        $0.contentInset = Const.collectionViewContentInset
        $0.backgroundColor = Color.white
        $0.showsHorizontalScrollIndicator = false
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
        addSubview(titleLabel)
        addSubview(showAllButton)
        addSubview(collectionView)
    }
    
    func setupViewConstraints() {
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(24)
            $0.bottom.equalTo(collectionView.snp.top).offset(-12)
        }
        showAllButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(24)
            $0.bottom.equalTo(collectionView.snp.top).offset(-8)
        }
        collectionView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(RecipeListCell.Const.cellHeight)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: CookedRecipeReactor) {
        // Action
        
        // State
        reactor.state.map { $0.mainDishRecipeCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.recipeCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}
