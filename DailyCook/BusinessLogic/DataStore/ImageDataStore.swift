//
//  ImageDataStore.swift
//  DailyCook
//
//  Created by admin on 2020/08/28.
//  Copyright © 2020 admin. All rights reserved.
//

import FirebaseStorage
import Firebase

struct ImageDataStore {
    private let storageReference: StorageReference
    
    init() {
        self.storageReference = Storage.storage().reference()
    }
    
    func createImage(imageData: Data, completion: @escaping ((Result<CookedRecipe, Error>) -> Void)) {
        let fileName = "\(UUID()).jpg"
        let imageRef = storageReference.child(fileName)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        _ = imageRef.putData(imageData, metadata: metaData) { metadata, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let cookedRecipe = CookedRecipe(date: Date(), imagePath: fileName)
                completion(.success(cookedRecipe))
            }
        }
    }
}
