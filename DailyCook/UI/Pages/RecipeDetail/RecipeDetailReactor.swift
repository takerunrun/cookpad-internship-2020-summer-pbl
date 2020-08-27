//
//  RecipeDetailReactor.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit

final class RecipeDetailReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let recipe: Recipe
        // TODO: Replace initial test data
        var cookedRecipeReactors: [RecipeDetailCookedRecipeReactor] = TestData.cookedRecipes(count: 2).map { RecipeDetailCookedRecipeReactor(cookedRecipe: $0) }
        
        init(recipe: Recipe) {
            self.recipe = recipe
        }
    }
    
    let initialState: State
    
    init() {
        // TODO: Replace initial test data
        initialState = State(recipe: TestData.recipe())
    }
}
