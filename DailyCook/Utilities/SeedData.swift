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
        createRecipe(
            name: "もやしナムル",
            number: 1,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/04/yamitsukimoyashi-768x512.jpg",
            category: .side,
            point: "週末に作り置きする時には倍量で作ってもいいでしょう！",
            recipeUrl: "https://mariegohan.com/2063"
        )
        createRecipe(
            name: "やみつき無限キャベツ",
            number: 2,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/06/IMG_3529-768x512.jpg",
            category: .side,
            point: "冷めても美味しいのでお弁当にもおすすめです",
            recipeUrl: "https://mariegohan.com/2669"
        )
        createRecipe(
            name: "鶏もも肉の塩レモンだれ",
            number: 3,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2018/02/IMG_0605-768x512.jpg",
            category: .main,
            point: "タレにつけた状態で冷蔵庫で4日、冷凍庫で1ヶ月持ちます",
            recipeUrl: "https://mariegohan.com/6825"
        )
        createRecipe(
            name: "チキンのトマト煮",
            number: 4,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2016/12/PC052350-768x576.jpg",
            category: .side,
            point: "ワイン不要、どこの家にも常備している調味料だけで作れます",
            recipeUrl: "https://mariegohan.com/734"
        )
        createRecipe(
            name: "豚汁",
            number: 5,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/04/yamitsukimoyashi-768x512.jpg",
            category: .soup,
            point: "みそは煮立てると香りが飛んでしまうため、野菜に火が通ったのを確認してから溶き入れて、すぐに火を止めましょう",
            recipeUrl: "https://chefgohan.gnavi.co.jp/detail/474"
        )
        createRecipe(
            name: "大根の中華サラダ",
            number: 6,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/12/IMG_8534-768x512.jpg",
            category: .side,
            point: "お酢を使うので日持ちし味がしっかり染みるのでお弁当にも入れられます",
            recipeUrl: "https://mariegohan.com/5542"
        )
        createRecipe(
            name: "豚バラ白菜のうま煮",
            number: 7,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/11/IMG_7783-768x512.jpg",
            category: .side,
            point: "フライパンひとつで簡単に作れる豚バラ肉と白菜のうま煮です",
            recipeUrl: "https://mariegohan.com/4860"
        )
        createRecipe(
            name: "かぼちゃのうま塩バター",
            number: 8,
            imageUrl: "https://mariegohan.com/sys/wp-content/uploads/2017/11/IMG_8417-1-768x512.jpg",
            category: .side,
            point: "レンジ蒸しにしたかぼちゃを塩とバターで味つけしたシンプルなおかずです",
            recipeUrl: "https://mariegohan.com/5349"
        )
        createRecipe(
            name: "卵スープ",
            number: 9,
            imageUrl: "https://c-chefgohan.gnst.jp/imgdata/recipe/48/04/448/rc732x546_1209170200_1d6d0398c06451d402ae30d2263a4ede.jpg",
            category: .soup,
            point: "火にかけてからもお玉で混ぜていくと、ひき肉はうまみを出しアクを吸って透明感がでます",
            recipeUrl: "https://chefgohan.gnavi.co.jp/detail/448"
        )
    }
}
