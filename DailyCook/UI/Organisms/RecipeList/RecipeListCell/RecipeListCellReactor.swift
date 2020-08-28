//
//  RecipeListCellReactor.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit

final class RecipeListCellReactor: Reactor {
    enum Action {}
    enum Mutation {}

    struct State {
        let recipe: Recipe
        
        init(recipe: Recipe) {
            self.recipe = recipe
        }
    }
    
    var initialState: State
    
    init(recipe: Recipe) {
        initialState = State(recipe: recipe)
    }
}

extension RecipeListCellReactor: Equatable {
    static func == (lhs: RecipeListCellReactor, rhs: RecipeListCellReactor) -> Bool {
        return lhs.currentState.recipe == rhs.currentState.recipe
    }
}
