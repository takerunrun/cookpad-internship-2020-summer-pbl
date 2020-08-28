//
//  CookedRecipeListCellReactor.swift
//  DailyCook
//
//  Created by admin on 2020/08/28.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit

final class CookedRecipeListCellReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let recipe: Recipe
        
        init(recipe: Recipe) {
            self.recipe = recipe
        }
    }
    
    var initialState: State
    
    init(recipe: Recipe) {
        initialState = State(recipe: recipe)
    }
}

extension CookedRecipeListCellReactor: Equatable {
    static func == (lhs: CookedRecipeListCellReactor, rhs: CookedRecipeListCellReactor) -> Bool {
        return lhs.currentState.recipe.id == rhs.currentState.recipe.id
    }
}
