//
//  CookedRecipeReactor.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit

final class CookedRecipeReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        var mainDishRecipeCellReactors: [RecipeListCellReactor] = TestData.recipes(count: 5).map { RecipeListCellReactor(recipe: $0) }
    }
    
    let initialState = State()
}
