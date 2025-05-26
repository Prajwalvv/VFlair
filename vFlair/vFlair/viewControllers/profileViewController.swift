//
//  profileViewController.swift
//  vFlair
//
//  Created by splash on 20/02/19.
//  Copyright © 2019 fluid. All rights reserved.
//

import UIKit
import Firebase
import expanding_collection
class profileViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var user: UserModel!
    var posts: [Post] = []
    typealias ItemInfo = (imageName: String, title: String)
    fileprivate var cellsIsOpen = [Bool]()
    fileprivate let items: [ItemInfo] = [("item0", "Boston"), ("item1", "New York"), ("item2", "San Francisco"), ("item3", "Washington")]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchUser()
        fetchMyPosts()
    }
    func fetchUser() {
        Api.User.observeCurrentUser { (user) in
            self.user = user
            self.collectionView.reloadData()
        }
    }
    func fetchMyPosts(){
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        Api.MyPosts.REF_MYPOSTS.child(currentUser.uid).observe(.childAdded, with: {
        snapshot in
            Api.Post.observePost(withId: snapshot.key, complation: {
                post in
                self.posts.append(post)
                self.collectionView.reloadData()
            })
        })
    }
}

extension profileViewController: UICollectionViewDataSource{
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
        }
//        headerViewCell.backgroundColor = UIColor.red
        return headerViewCell
    }
}

extension profileViewController: UICollectionViewDelegateFlowLayout{
    
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
//extension profileViewController {
//
//    fileprivate func registerCell() {
//
//        let nib = UINib(nibName: String(describing: profileViewController.self), bundle: nil)
//        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: profileViewController.self))
//    }
//
//    fileprivate func fillCellIsOpenArray() {
//        cellsIsOpen = Array(repeating: false, count: items.count)
//    }
//
//    fileprivate func getViewController() -> ExpandingTableViewController {
//        let toViewController: ExpandTableViewController = storyboard?.instantiateViewController(withIdentifier: "expand") as! ExpandTableViewController
//        return toViewController
//    }
//
//    fileprivate func configureNavBar() {
//        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//    }
//}
