//
//  SearchViewController.swift
//  vFlair
//
//  Created by splash on 06/04/19.
//  Copyright © 2019 fluid. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var users: [UserModel] = []
    var searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "search"
        searchBar.frame.size.width = view.frame.size.width - 60
        
        let searchItem = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = searchItem
        doSearch()
    }
    func doSearch() {
        if let searchText = searchBar.text?.lowercased() {
            self.users.removeAll()
            self.tableView.reloadData()
            Api.User.queryUsers(withText: searchText, completion: {
                (user) in
                self.isFollowing(userId: user.id!, completed: {
                    (value) in
                    user.isFollowing = value
                    self.users.append(user)
                    self.tableView.reloadData()
                })
            })
        }
    }
    func isFollowing(userId: String, completed: @escaping (Bool) -> Void ) {
        Api.Follow.isFollowing(userId: userId, completed: completed)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchToUserProfile"{
            let profileVC = segue.destination as! profileUserViewController
            let userId = sender as! String
            profileVC.userId = userId
            profileVC.delegate = self
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        doSearch()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        doSearch()
    }
}
extension SearchViewController: UITableViewDataSource{
    
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
extension SearchViewController: PeopleTableViewCellDelegate{
    func goToProfileUserVC(userId: String) {
        performSegue(withIdentifier: "searchToUserProfile", sender: userId)
    }
}
extension SearchViewController: nameheaderProfileCollectionReusableViewDelegat{
    func updateFollowButton(forUser user: UserModel) {
        for userMain in self.users {
            if userMain.id == user.id {
                userMain.isFollowing = user.isFollowing
                self.tableView.reloadData()
            }
        }
    }
}
