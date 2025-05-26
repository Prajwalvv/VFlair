//
//  comment.swift
//  vFlair
//
//  Created by Prajwal V.v on 09/12/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import Foundation
class Comment{
    var commentText: String?
    var uid: String?
}
extension Comment{
    static func trasformComment(dict: [String:Any]) -> Comment {
        let comment = Comment()
        comment.commentText = dict["commentText"] as? String
        comment.uid = dict["uid"] as? String
        return comment
    }
}
