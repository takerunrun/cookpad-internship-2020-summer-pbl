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
    private let collection: CollectionReference = Firestore.firestore().collection("recipes")
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return loadRecipes().map(Mutation.setRecipeCellReactors)
        }
    }
    
    private func loadRecipes() -> Observable<[Recipe]> {
        // TODO: Replace test data
//        return .just(TestData.recipeListRecipes())
        return fetchRecipesFromFirestore()
    }
    
    private func fetchRecipesFromFirestore() -> Observable<[Recipe]> {
        
        return Observable.create { (observer: AnyObserver<[Recipe]>) -> Disposable in
            self.collection.order(by: "number").getDocuments() { querySnapshot, error in
                if let error = error {
                    observer.onError(error)
                } else {
                    let firestoreRecipes = querySnapshot!.documents
                        // 取得したデータを FirestoreRecipe に変換
                        .compactMap { try? $0.data(as: FirestoreRecipe.self)  }
                    let recipes = firestoreRecipes.map { Recipe(firestoreRecipe: $0) }
                    observer.onNext(recipes)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
        
        
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
    
    func createRecipeDetailReactorFromTodaysRecipe() -> RecipeDetailReactor {
        return RecipeDetailReactor(recipe: currentState.todaysRecipe)
    }
    
    func createRecipeDetailReactor(indexPath: IndexPath) -> RecipeDetailReactor {
        let recipe = currentState.recipeCellReactors[indexPath.row].currentState.recipe
        return RecipeDetailReactor(recipe: recipe)
    }
}
