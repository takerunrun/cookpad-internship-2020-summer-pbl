//
//  RecipeDataStore.swift
//  DailyCook
//
//  Created by admin on 2020/08/28.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

struct RecipeDataStore {
    private let collection: CollectionReference

    init(db: Firestore = Firestore.firestore()) {
        self.collection = db.collection("recipes")
    }

    func updateRecipeWithCookedImageUrls(recipe: Recipe) -> Observable<Recipe> {
        return Observable.create { (observer: AnyObserver<Recipe>) -> Disposable in
            let updateData: [String: Any] = [
                "cookedImageUrls": recipe.cookedImageUrls
            ]
            self.collection.document(recipe.id).setData(updateData, merge: true) { error in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(recipe)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func updateRecipeWith(id: String, cookeRecipe: CookedRecipe) -> Observable<CookedRecipe> {
        return Observable.create { (observer: AnyObserver<CookedRecipe>) -> Disposable in
            self.collection.document(id).updateData([
                "cookedImageUrls": FieldValue.arrayUnion([cookeRecipe.imagePath])
            ]) { error in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(cookeRecipe)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
