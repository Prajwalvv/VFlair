//
//  headerProfileCollectionReusableView.swift
//  vFlair
//
//  Created by splash on 20/02/19.
//  Copyright © 2019 fluid. All rights reserved.
//

import UIKit
import Firebase

protocol nameheaderProfileCollectionReusableViewDelegat {
   func updateFollowButton(forUser user: UserModel)
}
class headerProfileCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var chasers: UILabel!
    @IBOutlet weak var contribution: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var delegate: nameheaderProfileCollectionReusableViewDelegat?
    
    var user: UserModel? {
        didSet {
            updateView()
        }
    }
    func updateView(){
            self.nameLable.text = user!.UserName
            if let photoUrlString = user!.profileImageUrl{
                let photoUrl = URL(string: photoUrlString)
                self.profileImage.sd_setImage(with: photoUrl)
            }
        
        Api.MyPosts.fetchCountMyPosts(userId: user!.id!) { (count) in
            self.contribution.text = "\(count)"
        }
        Api.Follow.fetchCountFollowers(userId: user!.id!) { (count) in
            self.chasers.text = "\(count)"
        }
        
        
        if user?.id == Api.User.CURRENT_USER?.uid {
            self.followButton.isHidden = true
        } else {
            updateStateFollowButton()
        }
    }
    func updateStateFollowButton() {
        if user!.isFollowing! {
            configureUnFollowButton()
        }else{
            configureFollowButton()
        }
}
    func configureFollowButton(){
        followButton.addTarget(self, action: #selector(self.followAction), for: UIControl.Event.touchUpInside)
        followButton.setImage(UIImage(named: "followW"), for: UIControl.State.normal)
    }
    
    func configureUnFollowButton(){
        followButton.setImage(UIImage(named: "followedW"), for: UIControl.State.normal)
        followButton.addTarget(self, action: #selector(self.unfollowAction), for: UIControl.Event.touchUpInside)
    }
    
    
    @objc func followAction() {
        if user!.isFollowing! == false{
            Api.Follow.followAction(withUser: user!.id!)
            configureUnFollowButton()
            user!.isFollowing! = true
            delegate?.updateFollowButton(forUser: user!)
        }
    }
    
    @objc func unfollowAction() {
        if user!.isFollowing! == true{
            Api.Follow.unFollowAction(withUser: user!.id!)
            configureFollowButton()
            user!.isFollowing! = false
            delegate?.updateFollowButton(forUser: user!)
        }
    }
}
