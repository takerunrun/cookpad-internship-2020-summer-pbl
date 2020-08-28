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
import RxGesture

final class RecipeListViewController: UIViewController, ReactorKit.View , ViewConstructor {
    
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
        $0.sectionInset.top = RecipeListHeaderView.Const.height + 48
    }).then {
        $0.register(Reusable.recipeCell)
        $0.contentInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        $0.backgroundColor = Color.white
    }
    
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
        
//        createSeedData()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        collectionView.addSubview(header)
        view.addSubview(collectionView)
        collectionView.refreshControl = refreshControl
    }
    
    func setupViewConstraints() {
        header.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.left.equalToSuperview()
            $0.width.equalTo(RecipeListHeaderView.Const.width)
            $0.height.equalTo(RecipeListHeaderView.Const.height)
        }
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: RecipeListReactor) {
        header.reactor = reactor
        
        // Action
        reactor.action.onNext(.load)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind { _ in
                print("valueChanged")
                reactor.action.onNext(.refresh)
            }
            .disposed(by: disposeBag)
        
        header.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                let viewController = RecipeDetailViewController().then {
                    $0.reactor = reactor.createRecipeDetailReactorFromTodaysRecipe()
                }
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                if reactor.isRecipeLocked(indexPath: indexPath) {
                    return
                }
                let viewController = RecipeDetailViewController().then {
                    $0.reactor = reactor.createRecipeDetailReactor(indexPath: indexPath)
                }
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.recipeCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.recipeCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .filter { !$0 }
            .bind { [weak self] _ in
                self?.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
    }
    
    func createSeedData() {
        let seedData = SeedData()
        seedData.createRecipes()
    }
}
