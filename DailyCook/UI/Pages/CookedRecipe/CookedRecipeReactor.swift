//
//  CookedRecipeReactor.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit

final class CookedRecipeReactor: Reactor {
    enum Action {
        case load
    }
    enum Mutation {
        case setMainDish([Recipe])
        case setSideDish([Recipe])
        case setSoup([Recipe])
    }
    
    struct State {
        // TODO: Replace initial test data
        var mainDishRecipeCellReactors: [RecipeListCellReactor] = TestData.recipes(count: 5).map { RecipeListCellReactor(recipe: $0) }
        var sideDishRecipeCellReactors: [RecipeListCellReactor] = TestData.recipes(count: 5).map { RecipeListCellReactor(recipe: $0) }
        var soupRecipeCellReactors: [RecipeListCellReactor] = TestData.recipes(count: 5).map { RecipeListCellReactor(recipe: $0) }
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return .empty()
        }
    }
    
    private func loadCookedRecipes() -> Observable<([Recipe], [Recipe], [Recipe])> {
        return .empty()
    }
    
    
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setMainDish(recipes):
            state.mainDishRecipeCellReactors = recipes.map { RecipeListCellReactor(recipe: $0) }
        case let .setSideDish(recipes):
            state.sideDishRecipeCellReactors = recipes.map { RecipeListCellReactor(recipe: $0) }
        case let .setSoup(recipes):
            state.soupRecipeCellReactors = recipes.map { RecipeListCellReactor(recipe: $0) }
        }
        return state
        
    }
    
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
