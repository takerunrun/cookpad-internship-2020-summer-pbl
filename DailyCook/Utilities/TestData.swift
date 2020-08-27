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
            number: Int.random(in: 1..<100),
            name: "やみつきキャベツ",
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/06/IMG_3529-768x512.jpg"
        )
    }
    
    static func recipes(count: Int) -> [Recipe] {
        return (0 ..< count).map { _ in recipe() }
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
