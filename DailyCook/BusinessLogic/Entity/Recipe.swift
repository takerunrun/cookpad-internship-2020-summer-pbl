//
//  Recipe.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct Recipe: Equatable {
    let id: String
    let number: Int
    let name: String
    let imageUrl: String
    let category: String
    let point: String
    let recipeUrl: String
    let isCooked: Bool
    let isSkipped: Bool
}

extension Recipe {
    init(firestoreRecipe: FirestoreRecipe) {
        self.id = firestoreRecipe.id ?? ""
        self.number = firestoreRecipe.number
        self.name = firestoreRecipe.name
        self.imageUrl = firestoreRecipe.imageUrl
        self.category = firestoreRecipe.category
        self.point = firestoreRecipe.point
        self.recipeUrl = firestoreRecipe.recipeUrl
        self.isCooked = firestoreRecipe.cookedImageUrls.count != 0
        self.isSkipped = firestoreRecipe.isSkipped
    }
}

enum RecipeCategory: String {
    case main
    case side
    case soup
}
