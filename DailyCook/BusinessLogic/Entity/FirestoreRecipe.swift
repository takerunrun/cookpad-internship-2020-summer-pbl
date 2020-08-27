//
//  FirestoreRecipe.swift
//  DailyCook
//
//  Created by admin on 2020/08/28.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

import Foundation
import FirebaseFirestoreSwift

struct FirestoreRecipe: Codable, Equatable {
    /// recipes/:id の id
    @DocumentID var id: String?
    var name: String
    var number: Int
    var imageUrl: String
    var category: String
    var point: String
    var recipeUrl: String
    var isSkipped: Bool
    var cookedImageUrls: [String]
}
