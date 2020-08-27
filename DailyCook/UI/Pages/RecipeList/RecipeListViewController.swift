//
//  RecipeListViewController.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class RecipeListViewController: UIViewController, ViewConstructor {
    
    // MARK: - Views
    private let header = RecipeListHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    func setupViews() {
        view.addSubview(header)
    }
    
    func setupViewConstraints() {
        header.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(RecipeListHeaderView.Const.width)
            $0.height.equalTo(RecipeListHeaderView.Const.height)
        }
    }
}
