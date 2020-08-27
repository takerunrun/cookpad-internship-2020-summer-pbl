//
//  CookedRecipeViewController.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit

final class CookedRecipeViewController: UIViewController, View, ViewConstructor {
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    
    private let scrollView = UIScrollView().then {
        $0.alwaysBounceVertical = true
        $0.showsVerticalScrollIndicator = false
        $0.contentInset.bottom = 24
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let mainDishView = CookedRecipeMainDishView()
    
    private let sideDishView = CookedRecipeSideDishView()
    
    private let soupView = CookedRecipeSoupView()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(mainDishView)
        stackView.setCustomSpacing(32, after: mainDishView)
        stackView.addArrangedSubview(sideDishView)
        stackView.setCustomSpacing(32, after: sideDishView)
        stackView.addArrangedSubview(soupView)
    }
    
    func setupViewConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: CookedRecipeReactor) {
        mainDishView.reactor = reactor
        sideDishView.reactor = reactor
        soupView.reactor = reactor
        
        // Action
        mainDishView.collectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                print(indexPath)
                let viewController = RecipeDetailViewController().then {
                    $0.reactor = RecipeDetailReactor()
                }
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        sideDishView.collectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                print(indexPath)
                let viewController = RecipeDetailViewController().then {
                    $0.reactor = RecipeDetailReactor()
                }
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        soupView.collectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                print(indexPath)
                let viewController = RecipeDetailViewController().then {
                    $0.reactor = RecipeDetailReactor()
                }
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        // State
    }
}
