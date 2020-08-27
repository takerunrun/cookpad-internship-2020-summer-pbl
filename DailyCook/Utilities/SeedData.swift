//
//  SeedData.swift
//  DailyCook
//
//  Created by admin on 2020/08/28.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Firebase

struct SeedData {
    private let collection: CollectionReference
    
    init(db: Firestore = Firestore.firestore()) {
        self.collection = db.collection("recipes")
    }
    
    func createRecipe(name: String, number: Int, imageUrl: String, category: RecipeCategory, point: String, recipeUrl: String) {
        let firestoreRecipe = FirestoreRecipe(
            id: "\(number)",
            name: name,
            number: number,
            imageUrl: imageUrl,
            category: category.rawValue,
            point: point,
            recipeUrl: recipeUrl,
            isSkipped: false,
            cookedImageUrls: []
        )
        _ = try! collection.addDocument(from: firestoreRecipe) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func createRecipes() {
        createRecipe(name: "もやしナムル ", number: 1, imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/04/yamitsukimoyashi-768x512.jpg", category: .side, point: "週末に作り置きする時には倍量で作ってもいいでしょう！", recipeUrl: "https://mariegohan.com/2063")
        createRecipe(name: "やみつき無限キャベツ ", number: 2, imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/06/IMG_3529-768x512.jpg", category: .side, point: "冷めても美味しいのでお弁当にもおすすめです", recipeUrl: "https://mariegohan.com/2669")
    }
}
