//
//  FeedApi.swift
//  vFlair
//
//  Created by splash on 25/03/19.
//  Copyright © 2019 fluid. All rights reserved.
//

import Foundation
import FirebaseDatabase
class FeedApi {
    var REF_FEED = Database.database().reference().child("feed")
    
    func observeFeed(withId id: String, completion: @escaping (Post) -> Void) {
        REF_FEED.child(id).queryOrdered(byChild: "timestamp").observe(.childAdded, with: {
            snapshot in
            let key = snapshot.key
            Api.Post.observePost(withId: key, complation: { (post) in
                completion(post)
            })
        })
    }
    func observeFeedRemoved(withId id: String, completion: @escaping (String) -> Void) {
        REF_FEED.child(id).observe(.childRemoved, with: {
            snapshot in
            let key = snapshot.key
            completion(key)
            })
        }
    }

