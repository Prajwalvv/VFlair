//
//  MyPostsApi.swift
//  vFlair
//
//  Created by splash on 27/02/19.
//  Copyright © 2019 fluid. All rights reserved.
//

import Foundation
import Firebase
class MyPostApi {
    var REF_MYPOSTS = Database.database().reference().child("MyPosts")
    
    
    func fetchMyPosts(userId: String, completion: @escaping(String)-> Void) {
        REF_MYPOSTS.child(userId).observe(.childAdded, with: {
            snapshot in
            completion(snapshot.key)
        })
    }
    func fetchCountMyPosts(userId: String, completion: @escaping (Int) -> Void) {
        REF_MYPOSTS.child(userId).observe(.value, with: {
            snapshot in
            let count = Int(snapshot.childrenCount)
            completion(count)
        })
    }
}

