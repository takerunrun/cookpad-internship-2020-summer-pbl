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
        var recipeCellReactors: [RecipeListCellReactor] = []
    }
    
    let initialState = State()
}
