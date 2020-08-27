//
//  RecipeListReactor.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit

final class RecipeListReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        // TODO: Replace initial data
        var recipeCellReactors: [RecipeListCellReactor] = TestData.recipes(count: 13).map { RecipeListCellReactor(recipe: $0) }
    }
    
    let initialState = State()
}
