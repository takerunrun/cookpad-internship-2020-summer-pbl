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
        // TODO: Replace initial test data
        var mainDishRecipeCellReactors: [RecipeListCellReactor] = TestData.recipes(count: 5).map { RecipeListCellReactor(recipe: $0) }
        var sideDishRecipeCellReactors: [RecipeListCellReactor] = TestData.recipes(count: 5).map { RecipeListCellReactor(recipe: $0) }
        var soupRecipeCellReactors: [RecipeListCellReactor] = TestData.recipes(count: 5).map { RecipeListCellReactor(recipe: $0) }
    }
    
    let initialState = State()
    
    func createRecipeDetailFromMainDish(indexPath: IndexPath) -> RecipeDetailReactor {
        let recipe = currentState.mainDishRecipeCellReactors[indexPath.row].currentState.recipe
        return RecipeDetailReactor(recipe: recipe)
    }
    
    func createRecipeDetailFromSideDish(indexPath: IndexPath) -> RecipeDetailReactor {
        let recipe = currentState.sideDishRecipeCellReactors[indexPath.row].currentState.recipe
        return RecipeDetailReactor(recipe: recipe)
    }
    
    func createRecipeDetailFromSoup(indexPath: IndexPath) -> RecipeDetailReactor {
        let recipe = currentState.soupRecipeCellReactors[indexPath.row].currentState.recipe
        return RecipeDetailReactor(recipe: recipe)
    }
}
