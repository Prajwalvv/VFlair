//
//  post.swift
//  vFlair
//
//  Created by Prajwal V.v on 29/11/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import Foundation
import Firebase
class Post{
    var caption: String?
    var photoUrl: String?
    var uid: String?
    var id: String?
    var happyCount: Int?
    var happy: Dictionary<String, Any>?
    var ishappy: Bool?
    var sadCount: Int?
    var sad: Dictionary<String, Any>?
    var isSad: Bool?
    var angryCount: Int?
    var angry: Dictionary<String,Any>?
    var isAngry: Bool?
    var coolCount: Int?
    var cool: Dictionary<String,Any>?
    var isCool: Bool?
    var boringCount: Int?
    var boring: Dictionary<String,Any>?
    var isBoring: Bool?
    var timestamp: Int?
}
extension Post{
    static func trasformPostPhoto(dict: [String:Any], key: String) -> Post {
        let post = Post()
        post.id = key
        post.caption = dict["caption"] as? String
        post.photoUrl = dict["photoUrl"] as? String
        post.uid = dict["uid"] as? String
        post.happyCount = dict["happyCount"] as? Int
        post.happy = dict["happy"] as? Dictionary<String, Any>
        if let currentUserId = Auth.auth().currentUser?.uid{
            if post.happy != nil{
                post.ishappy = post.happy![currentUserId] != nil
            }
        }
        post.sadCount = dict["sadCount"] as? Int
        post.sad = dict["sad"] as? Dictionary<String, Any>
        if let currentSadUserId = Auth.auth().currentUser?.uid{
            if post.sad != nil{
                post.isSad = post.sad![currentSadUserId] != nil
            }
        }
        post.angryCount = dict["angryCount"] as? Int
        post.angry = dict["angry"] as? Dictionary<String, Any>
        if let currentAngryUserId = Auth.auth().currentUser?.uid{
            if post.angry != nil{
                post.isAngry = post.angry![currentAngryUserId] != nil
            }
        }
        post.coolCount = dict["coolCount"] as? Int
        post.cool = dict["cool"] as? Dictionary<String, Any>
        if let currentCoolUserId = Auth.auth().currentUser?.uid{
            if post.cool != nil{
                post.isCool = post.cool![currentCoolUserId] != nil
            }
        }
        post.boringCount = dict["boringCount"] as? Int
        post.boring = dict["boring"] as? Dictionary<String, Any>
        if let currentBoringUserId = Auth.auth().currentUser?.uid{
            if post.boring != nil{
                post.isBoring = post.boring![currentBoringUserId] != nil
            }
        }
        post.timestamp = dict["timestamp"] as? Int
        if post.happyCount == nil {
            post.happyCount = 0
        }
        post.timestamp = dict["timestamp"] as? Int
        if post.sadCount == nil {
            post.sadCount = 0
        }
        post.timestamp = dict["timestamp"] as? Int
        if post.angryCount == nil {
            post.angryCount = 0
        }
        post.timestamp = dict["timestamp"] as? Int
        if post.coolCount == nil {
            post.coolCount = 0
        }
        post.timestamp = dict["timestamp"] as? Int
        if post.boringCount == nil {
            post.boringCount = 0
        }
    
        return post
    }
    static func trasformPostVideo(){
        
    }
    
}
