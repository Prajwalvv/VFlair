//
//  PeopleTableViewCell.swift
//  vFlair
//
//  Created by splash on 16/03/19.
//  Copyright © 2019 fluid. All rights reserved.
//

import UIKit
protocol PeopleTableViewCellDelegate {
    func goToProfileUserVC(userId: String)
}

class PeopleTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var followButton: UIButton!
    var delegate: PeopleTableViewCellDelegate?
    var peopleVC: PeopleViewController?
    var user: UserModel? {
        didSet {
            updateView()
        }
    }
    
    func updateView(){
        nameLable.text = user?.UserName
        if let photoUrlString = user?.profileImageUrl{
            let photoUrl = URL(string: photoUrlString)
            profileImage.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "profiledefault"))
            
        }
        
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
        }
    }
    
    @objc func unfollowAction() {
        if user!.isFollowing! == true{
       Api.Follow.unFollowAction(withUser: user!.id!)
        configureFollowButton()
            user!.isFollowing! = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.nameLable_touchUpInside))
        nameLable.addGestureRecognizer(tapGesture)
        nameLable.isUserInteractionEnabled = true
    }
    
    @objc func nameLable_touchUpInside(){
        if let id = user?.id {
            delegate?.goToProfileUserVC(userId: id)
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
