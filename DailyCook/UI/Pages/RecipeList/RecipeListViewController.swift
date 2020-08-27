//
//  RecipeListViewController.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReusableKit
import ReactorKit

final class RecipeListViewController: UIViewController, View , ViewConstructor {
    
    struct Reusable {
        static let recipeCell = ReusableCell<RecipeListCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let header = RecipeListHeaderView()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = RecipeListCell.Const.itemSize
        $0.minimumLineSpacing = 24
        $0.minimumInteritemSpacing = 16
        $0.scrollDirection = .vertical
    }).then {
        $0.register(Reusable.recipeCell)
        $0.contentInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        $0.backgroundColor = Color.white
    }
    
    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(collectionView)
    }
    
    func setupViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: RecipeListReactor) {
        // Action
        
        // State
        reactor.state.map { $0.recipeCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.recipeCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}
