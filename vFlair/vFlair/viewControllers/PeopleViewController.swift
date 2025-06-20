//
//  PeopleViewController.swift
//  vFlair
//
//  Created by splash on 16/03/19.
//  Copyright © 2019 fluid. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    var users: [UserModel] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsers()
    }
    
    func loadUsers(){
        Api.User.observeUsers { (user) in
            self.isFollowing(userId: user.id!, completed: {
                (value) in
                user.isFollowing = value
                self.users.append(user)
                self.tableView.reloadData()
            })
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileSegue"{
            let profileVC = segue.destination as! profileUserViewController
            let userId = sender as! String
            profileVC.userId = userId
            profileVC.delegate = self
        }
    }
    func isFollowing(userId: String, completed: @escaping (Bool) -> Void ) {
        Api.Follow.isFollowing(userId: userId, completed: completed)
    }
}

extension PeopleViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleTableViewCell", for: indexPath) as! PeopleTableViewCell
        let User = users[indexPath.row]
        cell.user = User
        cell.delegate = self
        return cell
    }
    
}

extension PeopleViewController: PeopleTableViewCellDelegate{
    func goToProfileUserVC(userId: String) {
        performSegue(withIdentifier: "ProfileSegue", sender: userId)
    }
}
extension PeopleViewController: nameheaderProfileCollectionReusableViewDelegat{
    func updateFollowButton(forUser user: UserModel) {
        for userMain in self.users {
            if userMain.id == user.id {
                userMain.isFollowing = user.isFollowing
                self.tableView.reloadData()
            }
        }
    }
}
