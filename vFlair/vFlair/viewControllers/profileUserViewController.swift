//
//  profileUserViewController.swift
//  vFlair
//
//  Created by splash on 18/04/19.
//  Copyright © 2019 fluid. All rights reserved.
//

import UIKit
import Firebase
import expanding_collection
class profileUserViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var user: UserModel!
    var posts: [Post] = []
    var userId = ""
    var delegate: nameheaderProfileCollectionReusableViewDelegat?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("userId:\(userId)")
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchUser()
        fetchMyPosts()
    }
    func fetchUser() {
        Api.User.observeUser(withId: userId) { (user) in
            self.isFollowing(userId: user.id!, completed: {
                (value) in
                user.isFollowing = value
                self.user = user
                self.collectionView.reloadData()
            })
        }
    }
    func isFollowing(userId: String, completed: @escaping (Bool) -> Void ) {
        Api.Follow.isFollowing(userId: userId, completed: completed)
    }
    func fetchMyPosts(){
        Api.MyPosts.fetchMyPosts(userId: userId) { (key) in
            Api.Post.observePost(withId: key, complation: {
                post in
                self.posts.append(post)
                self.collectionView.reloadData()
            })
        }
    }
}
extension profileUserViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! photoCollectionViewCell
        let post = posts[indexPath.row]
        cell.post = post
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerProfileCollectionReusableView", for: indexPath) as! headerProfileCollectionReusableView
        if let  user = self.user {
            headerViewCell.user = user
            headerViewCell.delegate = self.delegate
        }
        //        headerViewCell.backgroundColor = UIColor.red
        return headerViewCell
    }
}

extension profileUserViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3 - 1, height: collectionView.frame.size.height / 3 - 1)
    }
}
