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
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let mainDishView = CookedRecipeMainDishView()
    
    private let sideDishView = CookedRecipeSideDishView()
    
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
        
        // Action
        
        // State
    }
}
