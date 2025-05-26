//
//  postApi.swift
//  vFlair
//
//  Created by splash on 23/12/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import Foundation
import Firebase
class postApi {
    var REF_POSTS = Database.database().reference().child("posts")
    
    func observePost(complation: @escaping (Post) -> Void) {
        REF_POSTS.observe(.childAdded){ (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any]{
                let newPost = Post.trasformPostPhoto(dict: dict, key: snapshot.key)
                complation(newPost)
            }
        }
    }
    func observePost(withId uid: String, complation: @escaping (Post) -> Void){
        REF_POSTS.child(uid).observeSingleEvent(of: DataEventType.value, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any]{
                let post = Post.trasformPostPhoto(dict: dict, key: snapshot.key)
                complation(post)
            }
        })
    }
    func observeLikeCount(withPostId id: String, completion: @escaping (Int, UInt) -> Void) {
        var likeHandler: UInt!
        likeHandler = REF_POSTS.child(id).observe(.childChanged, with: {
            snapshot in
            if let value = snapshot.value as? Int {
                //  Database.database().reference().removeObserver(withHandle: ref)
                completion(value, likeHandler)
            }
        })
    }
    func observeTopPosts(completion: @escaping (Post) -> Void) {
        REF_POSTS.queryOrdered(byChild: "happyCount").observeSingleEvent(of: .value, with: {
            snapshot in
            let arraySnapshot = (snapshot.children.allObjects as! [DataSnapshot]).reversed()
            arraySnapshot.forEach({ (child) in
                if let dict = child.value as? [String: Any] {
                    let post = Post.trasformPostPhoto(dict: dict, key: child.key)
                    completion(post)
                }
            })
        })
    }
    func removeObserveLikeCount(id: String, likeHandler: UInt) {
        Api.Post.REF_POSTS.child(id).removeObserver(withHandle: likeHandler)
    }
    func incrementLikes(postId: String, onSucess: @escaping (Post) -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        let postRef = Api.Post.REF_POSTS.child(postId)
        postRef.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? [String : AnyObject], let uid = Api.User.CURRENT_USER?.uid {
                var likes: Dictionary<String, Bool>
                likes = post["likes"] as? [String : Bool] ?? [:]
                var likeCount = post["likeCount"] as? Int ?? 0
                if let _ = likes[uid] {
                    likeCount -= 1
                    likes.removeValue(forKey: uid)
                } else {
                    likeCount += 1
                    likes[uid] = true
                }
                post["likeCount"] = likeCount as AnyObject?
                post["likes"] = likes as AnyObject?
                
                currentData.value = post
                
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                onError(error.localizedDescription)
            }
            if let dict = snapshot?.value as? [String: Any] {
                let post = Post.trasformPostPhoto(dict: dict, key: snapshot!.key)
                onSucess(post)
            }
        }
    }
}

