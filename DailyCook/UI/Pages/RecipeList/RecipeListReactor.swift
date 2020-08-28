//
//  RecipeListReactor.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import Firebase

final class RecipeListReactor: Reactor {
    enum Action {
        case load
    }
    enum Mutation {
        case setRecipeCellReactors([Recipe])
    }
    
    struct State {
        var todaysRecipe: Recipe = TestData.noRecipe()
        var recipeCellReactors: [RecipeListCellReactor] = []
    }
    
    let initialState = State()
    private let recipeDataStore = RecipeDataStore()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return loadRecipes().map(Mutation.setRecipeCellReactors)
        }
    }
    
    private func loadRecipes() -> Observable<[Recipe]> {
        return recipeDataStore.fetchAllRecipes()
    }
    
    
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setRecipeCellReactors(recipes):
            var recipes = recipes
            if let index = recipes.firstIndex { $0.isCooked == false } {
                recipes[index].isLocked = false
                state.todaysRecipe = recipes[index]
            }
            state.recipeCellReactors = recipes.map { RecipeListCellReactor(recipe: $0) }
        }
        return state
    }
    
    func isRecipeLocked(indexPath: IndexPath) -> Bool {
        return currentState.recipeCellReactors[indexPath.row].currentState.recipe.isLocked
    }
    
    func createRecipeDetailReactorFromTodaysRecipe() -> RecipeDetailReactor {
        return RecipeDetailReactor(recipe: currentState.todaysRecipe)
    }
    
    func createRecipeDetailReactor(indexPath: IndexPath) -> RecipeDetailReactor {
        let recipe = currentState.recipeCellReactors[indexPath.row].currentState.recipe
        return RecipeDetailReactor(recipe: recipe)
    }
}
