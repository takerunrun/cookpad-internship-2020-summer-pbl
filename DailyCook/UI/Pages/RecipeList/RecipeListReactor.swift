//
//  RecipeListReactor.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit

final class RecipeListReactor: Reactor {
    enum Action {
        case load
    }
    enum Mutation {
        case setRecipeCellReactors([Recipe])
    }
    
    struct State {
        var recipeCellReactors: [RecipeListCellReactor] = []
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return loadRecipes().map(Mutation.setRecipeCellReactors)
        }
    }
    
    private func loadRecipes() -> Observable<[Recipe]> {
        // TODO: Replace test data
        return .just(TestData.recipes(count: 9))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setRecipeCellReactors(recipes):
            state.recipeCellReactors = recipes.map { RecipeListCellReactor(recipe: $0) }
        }
        return state
    }
}
