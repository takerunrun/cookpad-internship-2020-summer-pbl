//
//  RecipeDetailCookedRecipeReactor.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit

final class RecipeDetailCookedRecipeReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let cookedRecipe: CookedRecipe
        
        init(cookedRecipe: CookedRecipe) {
            self.cookedRecipe = cookedRecipe
        }
    }
    
    let initialState: State
    
    init(cookedRecipe: CookedRecipe) {
        initialState = State(cookedRecipe: cookedRecipe)
    }
}

extension RecipeDetailCookedRecipeReactor: Equatable {
    static func == (lhs: RecipeDetailCookedRecipeReactor, rhs: RecipeDetailCookedRecipeReactor) -> Bool {
        return lhs.currentState.cookedRecipe == rhs.currentState.cookedRecipe
    }
}
