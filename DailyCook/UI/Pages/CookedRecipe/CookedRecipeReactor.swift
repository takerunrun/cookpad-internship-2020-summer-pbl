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
        case refresh
    }
    enum Mutation {
        case setDish(([Recipe], [Recipe], [Recipe]))
        case setLoading(Bool)
    }
    
    struct State {
        var mainDishRecipeCellReactors: [CookedRecipeListCellReactor] = []
        var sideDishRecipeCellReactors: [CookedRecipeListCellReactor] = []
        var soupRecipeCellReactors: [CookedRecipeListCellReactor] = []
        var isLoading: Bool = false
    }
    
    let initialState = State()
    private let recipeDataStore = RecipeDataStore()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return loadCookedRecipes().map(Mutation.setDish)
        case .refresh:
            if currentState.isLoading { return .empty() }
            return Observable.concat([
                Observable.just(.setLoading(true)),
                loadCookedRecipes().map(Mutation.setDish),
                Observable.just(.setLoading(false)),
            ])
        }
    }
    
    private func loadCookedRecipes() -> Observable<([Recipe], [Recipe], [Recipe])> {
        return recipeDataStore.fetchAllRecipes().map { recipes in
            let main = recipes
                .filter { $0.category == RecipeCategory.main.rawValue }
                .filter { $0.cookedImageUrls.count > 0 }
            let side = recipes
                .filter { $0.category == RecipeCategory.side.rawValue }
                .filter { $0.cookedImageUrls.count > 0 }
            let soup = recipes
                .filter { $0.category == RecipeCategory.soup.rawValue }
                .filter { $0.cookedImageUrls.count > 0 }
            return (main, side, soup)
        }
    }
    
    
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setDish((mainRecipes, sideRecipes, soupRecies)):
            state.mainDishRecipeCellReactors = mainRecipes.map { CookedRecipeListCellReactor(recipe: $0) }
            state.sideDishRecipeCellReactors = sideRecipes.map { CookedRecipeListCellReactor(recipe: $0) }
            state.soupRecipeCellReactors = soupRecies.map { CookedRecipeListCellReactor(recipe: $0) }
        case let .setLoading(isLoading):
            state.isLoading = isLoading
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
