//
//  commentTableViewCell.swift
//  vFlair
//
//  Created by Prajwal V.v on 09/12/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import UIKit

protocol commentTableViewCellDelegate {
    func goToProfileUserVC(userId: String)
}
class commentTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var commentLable: UILabel!
    
    var delegate: commentTableViewCellDelegate?
    var comment: Comment? {
        didSet {
            updateView()
        }
    }
    var user: UserModel? {
        didSet {
            setupUserInfo()
        }
    }
    func updateView(){
        commentLable.text = comment?.commentText
        
    }
    func setupUserInfo(){
    nameLable.text = user?.UserName
    if let photoUrlString = user?.profileImageUrl{
    let photoUrl = URL(string: photoUrlString)
    profileImgView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "blackperson"))
    }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentLable.text = ""
        nameLable.text = ""
        profileImgView.layer.cornerRadius = profileImgView.frame.size.width / 2
        let tapGestureForLable = UITapGestureRecognizer(target: self, action: #selector(self.nameLable_touchUpInside))
        nameLable.addGestureRecognizer(tapGestureForLable)
        nameLable.isUserInteractionEnabled = true
    }
    @objc func nameLable_touchUpInside(){
        if let id = user?.id {
            delegate?.goToProfileUserVC(userId: id)
            
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImgView.image = UIImage(named: "blackperson")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
