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
        case setTodaysRecipe(Recipe)
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
            return .merge(
                loadTodaysRecipe().map(Mutation.setTodaysRecipe),
                loadRecipes().map(Mutation.setRecipeCellReactors)
            )
        }
    }
    
    private func loadTodaysRecipe() -> Observable<Recipe> {
        return .just(TestData.recipe())
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
                    print(recipes)
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
        case let .setTodaysRecipe(recipe):
            state.todaysRecipe = recipe
        case let .setRecipeCellReactors(recipes):
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
