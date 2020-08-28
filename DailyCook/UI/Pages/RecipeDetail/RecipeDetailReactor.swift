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
        case skip
        case postImageData(Data?)
    }
    enum Mutation {
        case setIsSkipped
        case addCookedRecipe(CookedRecipe)
    }
    
    struct State {
        var recipe: Recipe
        var cookedRecipeReactors: [RecipeDetailCookedRecipeReactor]
        
        init(recipe: Recipe) {
            self.recipe = recipe
            self.cookedRecipeReactors = recipe
                .cookedImageUrls
                .map { CookedRecipe(date: Date(), imagePath: $0) }
                .map { RecipeDetailCookedRecipeReactor(cookedRecipe: $0) }
        }
    }
    
    let initialState: State
    
    init(recipe: Recipe) {
        initialState = State(recipe: recipe)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .skip:
            return .just(.setIsSkipped)
        case let .postImageData(imageData):
            guard let imageData = imageData else { return .empty() }
            return createCookedRecipe(imageData: imageData)
                .flatMap(updateRecipe)
                .map(Mutation.addCookedRecipe)
        }
    }
    
    private func createCookedRecipe(imageData: Data) -> Observable<CookedRecipe> {
        let imageDataStore = ImageDataStore()
        return imageDataStore.createCookedRecipe(imageData: imageData)
    }
    
    private func updateRecipe(cookedRecipe: CookedRecipe) -> Observable<CookedRecipe> {
        let recipeDataStore = RecipeDataStore()
        return recipeDataStore.updateRecipeWith(id: currentState.recipe.id, cookeRecipe: cookedRecipe)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setIsSkipped:
            state.recipe.isSkipped = !state.recipe.isSkipped
        case let .addCookedRecipe(cookedRecipe):
            state.cookedRecipeReactors.append(RecipeDetailCookedRecipeReactor(cookedRecipe: cookedRecipe))
        }
        return state
    }
}
