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
        case refresh
    }
    enum Mutation {
        case setRecipeCellReactors([Recipe])
        case setLoading(Bool)
    }
    
    struct State {
        var todaysRecipe: Recipe = TestData.noRecipe()
        var recipeCellReactors: [RecipeListCellReactor] = []
        var isLoading: Bool = false
    }
    
    let initialState = State()
    private let recipeDataStore = RecipeDataStore()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return loadRecipes().map(Mutation.setRecipeCellReactors)
        case .refresh:
            if currentState.isLoading { return .empty() }
            return Observable.concat([
                Observable.just(.setLoading(true)),
                loadRecipes().map(Mutation.setRecipeCellReactors),
                Observable.just(.setLoading(false)),
            ])
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
            if let index = recipes.firstIndex { recipe in
                return !recipe.isCooked && !recipe.isSkipped
            } {
                recipes[index].isLocked = false
                state.todaysRecipe = recipes[index]
            }
            state.recipeCellReactors = recipes.map { RecipeListCellReactor(recipe: $0) }
        case let .setLoading(isLoading):
            state.isLoading = isLoading
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
