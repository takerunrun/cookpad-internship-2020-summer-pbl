//
//  TabBarController.swift
//  DailyCook
//
//  Created by admin on 2020/08/26.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    private struct Const {
        static let tabBarImages: [UIImage] = [#imageLiteral(resourceName: "home_empty"), #imageLiteral(resourceName: "user_empty")]
        static let tabBarSelectedImages: [UIImage] = [#imageLiteral(resourceName: "home_filled"), #imageLiteral(resourceName: "user_filled")]
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    // MARK: - Setup Methods
    private func setupViewControllers() {
        viewControllers = [
            UINavigationController(rootViewController: RecipeListViewController().then {
                $0.reactor = RecipeListReactor()
            }),
            UINavigationController(rootViewController: CookedRecipeViewController().then {
                $0.reactor = CookedRecipeReactor()
            }),
        ]

        tabBar.do {
            $0.isTranslucent = false
            $0.backgroundColor = Color.lightGray
            $0.tintColor = Color.textBlack
            $0.unselectedItemTintColor = Color.textGray
            $0.items?.enumerated().forEach { index, tabBarItem in
                tabBarItem.image = Const.tabBarImages[index]
                tabBarItem.selectedImage = Const.tabBarSelectedImages[index]
                tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
            }
        }
    }
}
