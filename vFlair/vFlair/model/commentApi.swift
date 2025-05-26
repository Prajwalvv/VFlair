//
//  commentApi.swift
//  vFlair
//
//  Created by splash on 23/12/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import Foundation
import Firebase
class commentApi {
    var REF_COMMENTS = Database.database().reference().child("comments")
    func observeComments(withPostId id: String, complation: @escaping (Comment) -> Void){
        REF_COMMENTS.child(id).observeSingleEvent(of: .value, with: {snapshot in
            if let dict = snapshot.value as? [String: Any]{
                let newComment = Comment.trasformComment(dict: dict)
                complation(newComment)
            }
        })
    }
}
