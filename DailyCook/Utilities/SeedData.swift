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
    
    func createRecipe(name: String, number: Int, imageUrl: String, category: RecipeCategory, point: String, recipeUrl: String, cookedImageUrls: [String] = []) {
        let firestoreRecipe = FirestoreRecipe(
            id: "\(number)",
            name: name,
            number: number,
            imageUrl: imageUrl,
            category: category.rawValue,
            point: point,
            recipeUrl: recipeUrl,
            isSkipped: false,
            cookedImageUrls: cookedImageUrls
        )
        _ = try! collection.addDocument(from: firestoreRecipe) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func createRecipes() {
        createRecipe(
            name: "もやしナムル",
            number: 1,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/04/yamitsukimoyashi-768x512.jpg",
            category: .side,
            point: "週末に作り置きする時には倍量で作ってもいいでしょう！",
            recipeUrl: "https://mariegohan.com/2063",
            cookedImageUrls: [
                "95D2FF33-2A37-4D5A-B35A-FAF8EF1D106B.jpg",
                "6976B5C9-4DA3-4FB4-A878-67257FA4207E.jpg",
                "A726CE4F-AAAF-45B1-8B31-40E609F53882.jpg"
            ]
        )
        createRecipe(
            name: "やみつき無限キャベツ",
            number: 2,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/06/IMG_3529-768x512.jpg",
            category: .side,
            point: "冷めても美味しいのでお弁当にもおすすめです",
            recipeUrl: "https://mariegohan.com/2669",
            cookedImageUrls: [
                "D0568F4F-DAC1-46C9-80EA-4699474F0BA1.jpg"
            ]
        )
        createRecipe(
            name: "鶏もも肉の塩レモンだれ",
            number: 3,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2018/02/IMG_0605-768x512.jpg",
            category: .main,
            point: "タレにつけた状態で冷蔵庫で4日、冷凍庫で1ヶ月持ちます",
            recipeUrl: "https://mariegohan.com/6825",
            cookedImageUrls: [
                "2EB64A5B-475C-4D27-9AEC-4418A2841CBC.jpg"
            ]
        )
        createRecipe(
            name: "チキンのトマト煮",
            number: 4,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2016/12/PC052350-768x576.jpg",
            category: .side,
            point: "ワイン不要、どこの家にも常備している調味料だけで作れます",
            recipeUrl: "https://mariegohan.com/734",
            cookedImageUrls: [
                "A9D12E1D-9733-422E-8554-6F9B4A1E9FB6.jpg"
            ]
        )
        createRecipe(
            name: "豚汁",
            number: 5,
            imageUrl: "https://c-chefgohan.gnst.jp/imgdata/recipe/74/04/474/rc732x546_1209180339_722bbd0bd61d2cfc3691fa4ff58e8921.jpg",
            category: .soup,
            point: "みそは煮立てると香りが飛んでしまうため、野菜に火が通ったのを確認してから溶き入れて、すぐに火を止めましょう",
            recipeUrl: "https://chefgohan.gnavi.co.jp/detail/474",
            cookedImageUrls: [
                "8E422D76-F4C0-49D6-A535-30147003B180.jpg"
            ]
        )
        createRecipe(
            name: "大根の中華サラダ",
            number: 6,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/12/IMG_8534-768x512.jpg",
            category: .side,
            point: "お酢を使うので日持ちし味がしっかり染みるのでお弁当にも入れられます",
            recipeUrl: "https://mariegohan.com/5542",
            cookedImageUrls: [
                "CABE30EB-B8D1-431C-994E-D5DDB9ACD767.jpg"
            ]
        )
        createRecipe(
            name: "豚バラ白菜のうま煮",
            number: 7,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/11/IMG_7783-768x512.jpg",
            category: .side,
            point: "フライパンひとつで簡単に作れる豚バラ肉と白菜のうま煮です",
            recipeUrl: "https://mariegohan.com/4860",
            cookedImageUrls: [
                "D4C473AD-70C6-404A-980D-7F7607418153.jpg"
            ]
        )
        createRecipe(
            name: "かぼちゃのうま塩バター",
            number: 8,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/11/IMG_8417-1-768x512.jpg",
            category: .side,
            point: "レンジ蒸しにしたかぼちゃを塩とバターで味つけしたシンプルなおかずです",
            recipeUrl: "https://mariegohan.com/5349"
//            cookedImageUrls: [
//                "BB72A592-BE56-4B8B-A157-1710A28CE593.jpg"
//            ]
        )
        createRecipe(
            name: "卵スープ",
            number: 9,
            imageUrl: "https://c-chefgohan.gnst.jp/imgdata/recipe/48/04/448/rc732x546_1209170200_1d6d0398c06451d402ae30d2263a4ede.jpg",
            category: .soup,
            point: "火にかけてからもお玉で混ぜていくと、ひき肉はうまみを出しアクを吸って透明感がでます",
            recipeUrl: "https://chefgohan.gnavi.co.jp/detail/448"
        )
        
        
        // Locked Recipe
        createRecipe(
            name: "もやしナムル",
            number: 10,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/04/yamitsukimoyashi-768x512.jpg",
            category: .side,
            point: "週末に作り置きする時には倍量で作ってもいいでしょう！",
            recipeUrl: "https://mariegohan.com/2063"
        )
        createRecipe(
            name: "やみつき無限キャベツ",
            number: 11,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/06/IMG_3529-768x512.jpg",
            category: .side,
            point: "冷めても美味しいのでお弁当にもおすすめです",
            recipeUrl: "https://mariegohan.com/2669"
        )
        createRecipe(
            name: "鶏もも肉の塩レモンだれ",
            number: 12,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2018/02/IMG_0605-768x512.jpg",
            category: .main,
            point: "タレにつけた状態で冷蔵庫で4日、冷凍庫で1ヶ月持ちます",
            recipeUrl: "https://mariegohan.com/6825"
        )
        createRecipe(
            name: "チキンのトマト煮",
            number: 13,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2016/12/PC052350-768x576.jpg",
            category: .side,
            point: "ワイン不要、どこの家にも常備している調味料だけで作れます",
            recipeUrl: "https://mariegohan.com/734"
        )
        createRecipe(
            name: "豚汁",
            number: 14,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/04/yamitsukimoyashi-768x512.jpg",
            category: .soup,
            point: "みそは煮立てると香りが飛んでしまうため、野菜に火が通ったのを確認してから溶き入れて、すぐに火を止めましょう",
            recipeUrl: "https://chefgohan.gnavi.co.jp/detail/474"
        )
        createRecipe(
            name: "大根の中華サラダ",
            number: 15,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/12/IMG_8534-768x512.jpg",
            category: .side,
            point: "お酢を使うので日持ちし味がしっかり染みるのでお弁当にも入れられます",
            recipeUrl: "https://mariegohan.com/5542"
        )
        createRecipe(
            name: "豚バラ白菜のうま煮",
            number: 16,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/11/IMG_7783-768x512.jpg",
            category: .side,
            point: "フライパンひとつで簡単に作れる豚バラ肉と白菜のうま煮です",
            recipeUrl: "https://mariegohan.com/4860"
        )
        createRecipe(
            name: "かぼちゃのうま塩バター",
            number: 17,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/11/IMG_8417-1-768x512.jpg",
            category: .side,
            point: "レンジ蒸しにしたかぼちゃを塩とバターで味つけしたシンプルなおかずです",
            recipeUrl: "https://mariegohan.com/5349"
        )
        createRecipe(
            name: "卵スープ",
            number: 18,
            imageUrl: "https://c-chefgohan.gnst.jp/imgdata/recipe/48/04/448/rc732x546_1209170200_1d6d0398c06451d402ae30d2263a4ede.jpg",
            category: .soup,
            point: "火にかけてからもお玉で混ぜていくと、ひき肉はうまみを出しアクを吸って透明感がでます",
            recipeUrl: "https://chefgohan.gnavi.co.jp/detail/448"
        )
    }
}
