//
//  homeViewController.swift
//  vFlair
//
//  Created by Prajwal V.v on 20/10/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import expanding_collection
class homeViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var posts = [Post]()
    var users = [UserModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadPosts()
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handelLogout), with : nil,
                    afterDelay: 0)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    func loadPosts() {
       self.activityIndicatorView.startAnimating()
        Api.Feed.observeFeed(withId: Api.User.CURRENT_USER!.uid) { (post) in
            guard let postId = post.uid else {
                return
            }
            self.fetchUser(uid: postId, completed: {
                self.posts.append(post)
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
            })
        }
        Api.Feed.observeFeedRemoved(withId: Api.User.CURRENT_USER!.uid) { (key) in
            self.posts = self.posts.filter{$0.id != key}
            self.tableView.reloadData()
        }
    }
    
    
    func fetchUser(uid: String, completed: @escaping () -> Void){
        Api.User.observeUser(withId: uid, complation: {
            user in
            self.users.append(user)
            completed()
        })
    }
    
    @IBAction func signoutType(_ sender: UIBarButtonItem) {
        handelLogout()
    }
    
    
    @objc func handelLogout()  {
        do{
            try Auth.auth().signOut()
        }catch let logoutError {
            print(logoutError)
        }
        performSegue(withIdentifier: "logout", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "commentView"{
            let commentVC = segue.destination as! commentViewController
            let postId = sender as! String
            commentVC.postId = postId
        }
        if segue.identifier == "HomeToUserProfile"{
            let profileVC = segue.destination as! profileUserViewController
            let userId = sender as! String
            profileVC.userId = userId
        }
    }
    

    @IBAction func add(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "PostPage", sender: nil)
    }
    
}

extension homeViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! homeTableViewCell
       let post = posts[indexPath.row]
       let user = users[indexPath.row]
        cell.post = post
        cell.user = user
        cell.delegate = self
        return cell
    }
}
extension homeViewController: homeTableViewCellDelegate {
    func goToCommentVC(postId: String) {
        performSegue(withIdentifier: "commentView", sender: postId)
    }
    func goToProfileUserVC(userId: String) {
        performSegue(withIdentifier: "HomeToUserProfile", sender: userId)
    }
}
