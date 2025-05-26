////
////  likesCounter.swift
////  vFlair
////
////  Created by splash on 25/12/18.
////  Copyright © 2018 fluid. All rights reserved.
////
//
//import Foundation
//import Firebase
//func incrementHappy(forRef ref : DatabaseReference){
//    ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
//        if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
//            print("value 1: \(currentData.value)")
//            var happy: Dictionary<String, Bool>
//            happy = post["happy"] as? [String : Bool] ?? [:]
//            var happyCount = post["happyCount"] as? Int ?? 0
//            if let _ = happy[uid] {
//                // Unstar the post and remove self from stars
//                happyCount -= 1
//                happy.removeValue(forKey: uid)
//            } else {
//                // Star the post and add self to stars
//                happyCount += 1
//                happy[uid] = true
//            }
//            post["happyCount"] = happyCount as AnyObject?
//            post["happy"] = happy as AnyObject?
//            
//            // Set value and report transaction success
//            currentData.value = post
//            
//            return TransactionResult.success(withValue: currentData)
//        }
//        return TransactionResult.success(withValue: currentData)
//    }) { (error, committed, snapshot) in
//        if let error = error {
//            print(error.localizedDescription)
//        }
//        if let dict = snapshot?.value as? [String: Any]{
//            let post = Post.trasformPostPhoto(dict: dict, key: snapshot!.key)
//            self.updatehappy(post: post)
//        }
//    }
//}
//func incrementSad(forRef ref : DatabaseReference){
//    ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
//        if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
//            print("value 1: \(currentData.value)")
//            var Sad: Dictionary<String, Bool>
//            Sad = post["Sad"] as? [String : Bool] ?? [:]
//            var SadCount = post["SadCount"] as? Int ?? 0
//            if let _ = Sad[uid] {
//                // Unstar the post and remove self from stars
//                SadCount -= 1
//                Sad.removeValue(forKey: uid)
//            } else {
//                // Star the post and add self to stars
//                SadCount += 1
//                Sad[uid] = true
//            }
//            post["SadCount"] = SadCount as AnyObject?
//            post["Sad"] = Sad as AnyObject?
//            
//            // Set value and report transaction success
//            currentData.value = post
//            
//            return TransactionResult.success(withValue: currentData)
//        }
//        return TransactionResult.success(withValue: currentData)
//    }) { (error, committed, snapshot) in
//        if let error = error {
//            print(error.localizedDescription)
//        }
//        if let dict = snapshot?.value as? [String: Any]{
//            let post = Post.trasformPostPhoto(dict: dict, key: snapshot!.key)
//            self.updateSad(post: post)
//        }
//    }
//}
//func incrementAngry(forRef ref : DatabaseReference){
//    ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
//        if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
//            print("value 1: \(currentData.value)")
//            var Angry: Dictionary<String, Bool>
//            Angry = post["Angry"] as? [String : Bool] ?? [:]
//            var AngryCount = post["AngryCount"] as? Int ?? 0
//            if let _ = Angry[uid] {
//                // Unstar the post and remove self from stars
//                AngryCount -= 1
//                Angry.removeValue(forKey: uid)
//            } else {
//                // Star the post and add self to stars
//                AngryCount += 1
//                Angry[uid] = true
//            }
//            post["AngryCount"] = AngryCount as AnyObject?
//            post["Angry"] = Angry as AnyObject?
//            
//            // Set value and report transaction success
//            currentData.value = post
//            
//            return TransactionResult.success(withValue: currentData)
//        }
//        return TransactionResult.success(withValue: currentData)
//    }) { (error, committed, snapshot) in
//        if let error = error {
//            print(error.localizedDescription)
//        }
//        if let dict = snapshot?.value as? [String: Any]{
//            let post = Post.trasformPostPhoto(dict: dict, key: snapshot!.key)
//            self.updateAngry(post: post)
//        }
//    }
//}
//
//func incrementCool(forRef ref : DatabaseReference){
//    ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
//        if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
//            print("value 1: \(currentData.value)")
//            var Cool: Dictionary<String, Bool>
//            Cool = post["Cool"] as? [String : Bool] ?? [:]
//            var CoolCount = post["CoolCount"] as? Int ?? 0
//            if let _ = Cool[uid] {
//                // Unstar the post and remove self from stars
//                CoolCount -= 1
//                Cool.removeValue(forKey: uid)
//            } else {
//                // Star the post and add self to stars
//                CoolCount += 1
//                Cool[uid] = true
//            }
//            post["CoolCount"] = CoolCount as AnyObject?
//            post["Cool"] = Cool as AnyObject?
//            
//            // Set value and report transaction success
//            currentData.value = post
//            
//            return TransactionResult.success(withValue: currentData)
//        }
//        return TransactionResult.success(withValue: currentData)
//    }) { (error, committed, snapshot) in
//        if let error = error {
//            print(error.localizedDescription)
//        }
//        if let dict = snapshot?.value as? [String: Any]{
//            let post = Post.trasformPostPhoto(dict: dict, key: snapshot!.key)
//            self.updateCool(post: post)
//        }
//    }
//}
//
//func incrementConfused(forRef ref : DatabaseReference){
//    ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
//        if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
//            print("value 1: \(currentData.value)")
//            var Confused: Dictionary<String, Bool>
//            Confused = post["Confused"] as? [String : Bool] ?? [:]
//            var ConfusedCount = post["ConfusedCount"] as? Int ?? 0
//            if let _ = Confused[uid] {
//                // Unstar the post and remove self from stars
//                ConfusedCount -= 1
//                Confused.removeValue(forKey: uid)
//            } else {
//                // Star the post and add self to stars
//                ConfusedCount += 1
//                Confused[uid] = true
//            }
//            post["ConfusedCount"] = ConfusedCount as AnyObject?
//            post["Confused"] = Confused as AnyObject?
//            
//            // Set value and report transaction success
//            currentData.value = post
//            
//            return TransactionResult.success(withValue: currentData)
//        }
//        return TransactionResult.success(withValue: currentData)
//    }) { (error, committed, snapshot) in
//        if let error = error {
//            print(error.localizedDescription)
//        }
//        if let dict = snapshot?.value as? [String: Any]{
//            let post = Post.trasformPostPhoto(dict: dict, key: snapshot!.key)
//            self.updateHappy(post: post)
//        }
//    }
//}
//
