//
//  TestData.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct TestData {
    static func recipe() -> Recipe {
        return Recipe(
            id: testID(),
            number: Int.random(in: 1 ..< 100),
            name: "やみつきキャベツ",
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/06/IMG_3529-768x512.jpg",
            category: "副菜",
            point: "みそは煮立てると香りが飛んでしまうため、野菜に火が通ったのを確認してから溶き入れて、すぐに火を止めましょう。",
            recipeUrl: "https://mariegohan.com/2669",
            isCooked: false,
            isSkipped: false
        )
    }
    
    static func recipes(count: Int) -> [Recipe] {
        return (0 ..< count).map { _ in recipe() }
    }
    
    static func recipe(isCooked: Bool, isSkipped: Bool) -> Recipe {
        return Recipe(
            id: testID(),
            number: Int.random(in: 1 ..< 100),
            name: "やみつきキャベツ",
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/06/IMG_3529-768x512.jpg",
            category: "副菜",
            point: "みそは煮立てると香りが飛んでしまうため、野菜に火が通ったのを確認してから溶き入れて、すぐに火を止めましょう。",
            recipeUrl: "https://mariegohan.com/2669",
            isCooked: isCooked,
            isSkipped: isSkipped
        )
    }
    
    static func recipeListRecipes() -> [Recipe] {
        return [
            recipe(isCooked: true, isSkipped: false),
            recipe(isCooked: true, isSkipped: false),
            recipe(isCooked: true, isSkipped: false),
            recipe(isCooked: true, isSkipped: true),
            recipe(isCooked: true, isSkipped: false),
            recipe(isCooked: true, isSkipped: false),
            recipe(isCooked: true, isSkipped: false),
            recipe(isCooked: false, isSkipped: false),
            recipe(isCooked: false, isSkipped: false),
            recipe(isCooked: false, isSkipped: false),
            recipe(isCooked: false, isSkipped: false),
            recipe(isCooked: false, isSkipped: false),
            recipe(isCooked: false, isSkipped: false),
        ]
    }
    
    static func noRecipe() -> Recipe {
        return Recipe(
            id: "norecipe",
            number: 0,
            name: "ちょっと待ってね",
            imageUrl: "https://parisdayhotel.com/assets/images/noimage.png",
            category: "副菜",
            point: "みそは煮立てると香りが飛んでしまうため、野菜に火が通ったのを確認してから溶き入れて、すぐに火を止めましょう。",
            recipeUrl: "https://mariegohan.com/2669",
            isCooked: false,
            isSkipped: false
        )
    }
    
    static func cookedRecipe() -> CookedRecipe {
        return CookedRecipe(date: Date.init(), imageUrl: "https://www2.katagi.co.jp/recipe/.assets/%E6%98%A5%E3%82%AD%E3%83%A3%E3%83%99%E3%83%84%E3%81%AE%E3%82%84%E3%81%BF%E3%81%A4%E3%81%8D%E3%82%AD%E3%83%A3%E3%83%99%E3%83%84.jpg")
    }
    
    static func cookedRecipes(count: Int) -> [CookedRecipe] {
        return (0 ..< count).map { _ in cookedRecipe() }
    }
    
    private static func testID() -> String {
        return randomString(length: 32)
    }
    
    private static func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
}
