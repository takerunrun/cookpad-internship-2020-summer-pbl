//
//  RecipeDetailViewController.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import ReusableKit

final class RecipeDetailViewController: UIViewController, View, ViewConstructor {
    
    struct Reusable {
        static let cookedRecipeCell = ReusableCell<RecipeDetailCookedRecipeCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let contentScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let header = RecipeDetailHeaderView()
    
    private let cookedRecipeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = RecipeDetailCookedRecipeCell.Const.itemSize
        $0.minimumLineSpacing = 0
    }).then {
        $0.register(Reusable.cookedRecipeCell)
        $0.backgroundColor = Color.white
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(stackView)
        stackView.addArrangedSubview(header)
        stackView.setCustomSpacing(32, after: header)
        stackView.addArrangedSubview(cookedRecipeCollectionView)
    }
    
    func setupViewConstraints() {
        contentScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        header.snp.makeConstraints {
            $0.width.equalTo(DeviceSize.screenWidth)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: RecipeDetailReactor) {
        header.reactor = reactor
        
        // Action
        header.recipeUrlButton.rx.tap
            .bind { [weak self] in
                let viewController = WebRecipeViewController(url: reactor.currentState.recipe.recipeUrl)
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.cookedRecipeReactors }
            .distinctUntilChanged()
            .bind(to: cookedRecipeCollectionView.rx.items(Reusable.cookedRecipeCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.cookedRecipeReactors.count }
        .distinctUntilChanged()
            .bind { [weak self] count in
                self?.cookedRecipeCollectionView.removeConstraints(self?.cookedRecipeCollectionView.constraints ?? [])
                self?.cookedRecipeCollectionView.snp.makeConstraints {
                    $0.width.equalTo(DeviceSize.screenWidth)
                    $0.height.equalTo(RecipeDetailCookedRecipeCell.Const.cellHeight * CGFloat(count))
                }
            }
            .disposed(by: disposeBag)
    }
}
