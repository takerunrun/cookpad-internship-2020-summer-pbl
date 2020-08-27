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
