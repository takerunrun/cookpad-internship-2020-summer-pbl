//
//  RecipeDetailReactor.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit

final class RecipeDetailReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let recipeDetail: RecipeDetail
        
        init(recipeDetail: RecipeDetail) {
            self.recipeDetail = recipeDetail
        }
    }
    
    let initialState: State
    
    init() {
        // TODO: Replace initial test data
        initialState = State(recipeDetail: TestData.recipeDetail())
    }
}
