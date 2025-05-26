//
//  user.swift
//  vFlair
//
//  Created by Prajwal V.v on 04/12/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import Foundation
class UserModel{
    var email: String?
    var profileImageUrl: String?
    var UserName: String?
    var id: String?
    var isFollowing: Bool?
}

extension UserModel{
    static func transformUser(dict:[String: Any], key: String) -> UserModel{
        let user = UserModel()
        user.email = dict["email"] as? String
        user.profileImageUrl = dict["profileImageUrl"] as? String
        user.UserName = dict["username"] as? String
        user.id = key
        return user
    }
}

