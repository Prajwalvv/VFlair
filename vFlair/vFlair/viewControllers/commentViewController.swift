//
//  commentViewController.swift
//  vFlair
//
//  Created by Prajwal V.v on 09/12/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class commentViewController: UIViewController {
    @IBOutlet weak var commentTextField: UITextField!
    var postId : String!
    var post: Post?
    var comments = [Comment]()
    var users = [UserModel]()
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var captionInComment: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "comment"
empty()
        handleTextField()
        loadComments()
        captionInComment.text = post?.caption
        tableView.dataSource = self
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHIde(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification){
         let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            UIView.animate(withDuration: 0.3){
                self.bottomConstraint.constant = -keyboardSize!.height
                self.view.layoutIfNeeded()
            }
    }
    @objc func keyboardWillHIde(_ notification: NSNotification){
        UIView.animate(withDuration: 0.3){
            self.bottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    
    func loadComments() {
        Api.Post_Comment.REF_POSTS_COMMENTS.child(self.postId).observe(.childAdded, with: { snapshot in
            Api.comment.observeComments(withPostId: snapshot.key, complation: { comment in
                self.fetchUser(uid: comment.uid!, completed: {
                    self.comments.append(comment)
                    self.tableView.reloadData()
                })
            })
        })
    }
    func fetchUser(uid: String, completed: @escaping () -> Void){
        Api.User.observeUser(withId: uid, complation: {
            user in
            self.users.append(user)
            completed()
        })
    }
    
    
    func handleTextField() {
        commentTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    @objc func textFieldDidChange(){
        if let commentText = commentTextField.text,!commentText.isEmpty{
            sendButton.setTitleColor(UIColor.green, for: UIControl.State.normal)
            sendButton.isEnabled = true
            return
        }
        sendButton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        sendButton.isEnabled = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false 
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
        let commentReference = Api.comment.REF_COMMENTS
        let newCommentId = commentReference.childByAutoId().key
        let newcommentReference = commentReference.child(newCommentId)
        guard let currentUser = Auth.auth().currentUser else{
            return
        }
        let currentUserId = currentUser.uid
        newcommentReference.setValue(["uid": currentUserId, "commentText": commentTextField.text!]) { (Error, ref) in
            if Error != nil {
        AlertController.showAlert(inViewController: self, title: "Error", message: "type some comment")
                return
            }
            
            let postCommentsRef = Api.Post_Comment.REF_POSTS_COMMENTS.child(self.postId).child(newCommentId)
            postCommentsRef.setValue(true,withCompletionBlock: {
                (error, ref ) in
                if error != nil{
                    AlertController.showAlert(inViewController: self, title: "Error", message: "type some comment")
                    return
                }
            })
            self.empty()
            self.view.endEditing(true)
        }
        
    }
    func empty() {
        self.commentTextField.text = ""
        self.sendButton.isEnabled = false
        self.sendButton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "commentToUserProfile"{
            let profileVC = segue.destination as! profileUserViewController
            let userId = sender as! String
            profileVC.userId = userId
        }
    }
}
extension commentViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! commentTableViewCell
        let comment = comments[indexPath.row]
        let user = users[indexPath.row]
        cell.comment = comment
        cell.user = user
        cell.delegate = self
        return cell
    }
    
}
extension commentViewController: commentTableViewCellDelegate{
    func goToProfileUserVC(userId: String) {
        performSegue(withIdentifier: "commentToUserProfile", sender: userId)
    }
}
