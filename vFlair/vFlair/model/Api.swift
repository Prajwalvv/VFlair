//
//  Api.swift
//  vFlair
//
//  Created by splash on 23/12/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import Foundation
struct  Api {
    static var User = UserApi()
    static var Post = postApi()
    static var comment = commentApi()
    static var Post_Comment = Post_CommentApi()
    static var MyPosts = MyPostApi()
    static var Follow = FollowApi()
    static var Feed = FeedApi()
    static var HashTag = HashTagApi()
    static var Notification = NotificationApi()
}
