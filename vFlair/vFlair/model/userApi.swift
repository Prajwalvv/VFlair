//
//  userApi.swift
//  vFlair
//
//  Created by splash on 23/12/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
class UserApi {
    var REF_USERS = Database.database().reference().child("users")
    
    func observeUser(withId uid: String, complation: @escaping (UserModel) -> Void){
   REF_USERS.child(uid).observeSingleEvent(of: .value, with: {
            snapshot in
    if let dict = snapshot.value as? [String: Any]{
        let user = UserModel.transformUser (dict: dict, key: snapshot.key)
             complation(user)
           }
       })
    }
    func observeCurrentUser(completion: @escaping (UserModel) -> Void){
        guard let currentUser = Auth.auth().currentUser else{
            return 
        }
        REF_USERS.child(currentUser.uid).observeSingleEvent(of: .value, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any]{
                let user = UserModel.transformUser (dict: dict, key: snapshot.key)
                completion(user)
            }
        })
    }
    
    func observeUsers(completion: @escaping (UserModel) -> Void) {
        REF_USERS.observe(.childAdded, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any]{
                let user = UserModel.transformUser (dict: dict, key: snapshot.key)
                if user.id! != self.CURRENT_USER?.uid {
                completion(user)
                }
            }
        })
    }
    
    func queryUsers(withText text: String, completion: @escaping (UserModel) -> Void) {
        REF_USERS.queryOrdered(byChild: "username_lowercase").queryStarting(atValue: text).queryEnding(atValue: text+"\u{f8ff}").queryLimited(toFirst: 10).observeSingleEvent(of: .value, with: {
            snapshot in
            snapshot.children.forEach({ (s) in
                let child = s as! DataSnapshot
                if let dict = child.value as? [String: Any] {
                    let user = UserModel.transformUser(dict: dict, key: child.key)
                    completion(user)
                }
            })
        })
    }
    
    var AUTH_TYPE = Auth.auth()

    var CURRENT_USER: User? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser
        }
        
        return nil
    }

    
    var REF_CURRENT_USER: DatabaseReference? {
        guard let currentUser = Auth.auth().currentUser else{
            return nil
        }
        return REF_USERS.child(currentUser.uid)
    }
}
