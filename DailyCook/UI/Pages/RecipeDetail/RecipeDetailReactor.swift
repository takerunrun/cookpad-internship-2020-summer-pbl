//
//  RecipeDetailReactor.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit

final class RecipeDetailReactor: Reactor {
    enum Action {
        case postImageData(Data?)
    }
    enum Mutation {
        case addCookedRecipe(CookedRecipe)
    }
    
    struct State {
        let recipe: Recipe
        // TODO: Replace initial test data
        var cookedRecipeReactors: [RecipeDetailCookedRecipeReactor] = TestData.cookedRecipes(count: 2).map { RecipeDetailCookedRecipeReactor(cookedRecipe: $0) }
        
        init(recipe: Recipe) {
            self.recipe = recipe
        }
    }
    
    let initialState: State
    
    init(recipe: Recipe) {
        initialState = State(recipe: recipe)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .postImageData(imageData):
            guard let imageData = imageData else { return .empty() }
            return createCookedRecipe(imageData: imageData).map(Mutation.addCookedRecipe)
        }
    }
    
    private func createCookedRecipe(imageData: Data) -> Observable<CookedRecipe> {
        let imageDataStore = ImageDataStore()
        return imageDataStore.createCookedRecipe(imageData: imageData)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .addCookedRecipe(cookedRecipe):
            state.cookedRecipeReactors.append(RecipeDetailCookedRecipeReactor(cookedRecipe: cookedRecipe))
        }
        return state
    }
}
