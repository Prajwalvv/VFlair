//
//  homeTableViewCell.swift
//  vFlair
//
//  Created by Prajwal V.v on 29/11/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
protocol homeTableViewCellDelegate {
    func goToCommentVC(postId: String)
    func goToProfileUserVC(userId: String)
}
class homeTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var backProfile: UIView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var happyImageView: UIImageView!
    @IBOutlet weak var angryImageView: UIImageView!
    @IBOutlet weak var uiView: segmentUiView!
    @IBOutlet weak var coolImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var boringImageView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var sadImageView: UIImageView!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var happyCount: UILabel!
    @IBOutlet weak var confusedCount: UILabel!
    @IBOutlet weak var angerCount: UILabel!
    @IBOutlet weak var sadCount: UILabel!
    @IBOutlet weak var coolCount: UILabel!
    @IBOutlet weak var caprionLable: UILabel!
//    @IBOutlet weak var backConstraintY: NSLayoutConstraint!
//    @IBOutlet weak var frontConstraintY: NSLayoutConstraint!
    
    var delegate: homeTableViewCellDelegate?
    var postRef : DatabaseReference!
    var post: Post? {
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
        caprionLable.text = post?.caption
        if let photoUrlString = post?.photoUrl{
            let photoUrl = URL(string: photoUrlString)
            postImageView.sd_setImage(with: photoUrl)
        }
        
        Api.Post.REF_POSTS.child(post!.id!).observeSingleEvent(of: .value ,with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any]{
                let post = Post.trasformPostPhoto(dict: dict, key: snapshot.key)
                self.updateHappy(post: post)
            }
            if let dictSad = snapshot.value as? [String: Any]{
                 let post = Post.trasformPostPhoto(dict: dictSad, key: snapshot.key)
                self.updateSad(post: post)
            }
            if let dictAngry = snapshot.value as? [String: Any]{
                let post = Post.trasformPostPhoto(dict: dictAngry, key: snapshot.key)
                self.updateAngry(post: post)
            }
            if let dictCool = snapshot.value as? [String: Any]{
                let post = Post.trasformPostPhoto(dict: dictCool, key: snapshot.key)
                self.updateCool(post: post)
            }
            if let dictBoring = snapshot.value as? [String: Any]{
                let post = Post.trasformPostPhoto(dict: dictBoring, key: snapshot.key)
                self.updateBoring(post: post)
            }
        })
        Api.Post.REF_POSTS.child(post!.id!).observe(.childMoved,with: {
            snapshot in

            if let value = snapshot.value as? Int {
                self.happyCount.text = String(value)
                self.sadCount.text = String(value)
                self.angerCount.text = String(value)
                self.coolCount.text = String(value)
                self.confusedCount.text = String(value)
            }
            
        })
       
        
        
//        end of updateView
    }
    func updateHappy(post: Post){
        let imageName = post.happy == nil || !post.ishappy! ? "Wlol" : "Wlol_filled"
        happyImageView.image = UIImage(named: imageName)
        guard let count = post.happyCount else {
            return
        }
        if count != 0{
            happyCount.text = String(count)
        }else{
            sadImageView.isUserInteractionEnabled = true
            angryImageView.isUserInteractionEnabled = true
            coolImageView.isUserInteractionEnabled = true
            boringImageView.isUserInteractionEnabled = true
            happyCount.text = "0"
        }
    }
    func updateSad(post: Post){
        let imageName = post.sad == nil || !post.isSad! ? "Wdisappointed" : "Wdisappointed_filled"
    sadImageView.image = UIImage(named: imageName)
        guard let count = post.sadCount else {
            return
        }
        if count != 0{
            sadCount.text = String(count)
        }else{
            happyImageView.isUserInteractionEnabled = true
            angryImageView.isUserInteractionEnabled = true
            coolImageView.isUserInteractionEnabled = true
            boringImageView.isUserInteractionEnabled = true
            sadCount.text = "0"
        }
    }
    func updateAngry(post: Post){
        let imageName = post.angry == nil || !post.isAngry! ? "Wangry" : "Wangry_filled"
        angryImageView.image = UIImage(named: imageName)
        guard let count = post.angryCount else {
            return
        }
        if count != 0{
            angerCount.text = String(count)
        }else{
            sadImageView.isUserInteractionEnabled = true
            happyImageView.isUserInteractionEnabled = true
            coolImageView.isUserInteractionEnabled = true
            boringImageView.isUserInteractionEnabled = true
            angerCount.text = "0"
        }
    }
    func updateCool(post: Post){
        let imageName = post.cool == nil || !post.isCool! ? "Wcool" : "Wcool_filled"
        coolImageView.image = UIImage(named: imageName)
        guard let count = post.coolCount else {
            return
        }
        if count != 0{
            
            coolCount.text = String(count)
        }else{
            sadImageView.isUserInteractionEnabled = true
            happyImageView.isUserInteractionEnabled = true
            angryImageView.isUserInteractionEnabled = true
            boringImageView.isUserInteractionEnabled = true
            coolCount.text = "0"
        }
    }
    func updateBoring(post: Post){
        let imageName = post.boring == nil || !post.isBoring! ? "Wboring" : "Wboring_filled"
        boringImageView.image = UIImage(named: imageName)
        guard let count = post.boringCount else {
            return
        }
        if count != 0{
            confusedCount.text = String(count)
        }else{
            sadImageView.isUserInteractionEnabled = true
            happyImageView.isUserInteractionEnabled = true
            angryImageView.isUserInteractionEnabled = true
            coolImageView.isUserInteractionEnabled = true
            confusedCount.text = "0"
        }
    }
    

    
    func setupUserInfo(){
        nameLable.text = user?.UserName
        if let photoUrlString = user?.profileImageUrl{
            let photoUrl = URL(string: photoUrlString)
            profileImageView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "profiledefault"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//        postImageView.isUserInteractionEnabled = true
//        postImageView.addGestureRecognizer(tapGestureRecognizer)
        // Initialization code
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        postImageView.layer.cornerRadius = postImageView.frame.size.width / 29
        postImageView.clipsToBounds = true
        backView.layer.cornerRadius = backView.frame.size.width / 24
        backView.clipsToBounds = true
        uiView.layer.cornerRadius = uiView.frame.size.width / 24
        uiView.clipsToBounds = true
        nameLable.text = ""
        caprionLable.text = ""
        backProfile.layer.cornerRadius = backProfile.frame.size.width / 2
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.commentImageView_touchUpInside))
        commentImageView.addGestureRecognizer(tapGesture)
        commentImageView.isUserInteractionEnabled = true
        let tapGestureForhappy = UITapGestureRecognizer(target: self, action: #selector(self.happyImageView_touchUpInside))
        happyImageView.addGestureRecognizer(tapGestureForhappy)
        happyImageView.isUserInteractionEnabled = true
        let tapGestureForSad = UITapGestureRecognizer(target: self, action: #selector(self.sadImageView_touchUpInside))
        sadImageView.addGestureRecognizer(tapGestureForSad)
        sadImageView.isUserInteractionEnabled = true
        let tapGestureForangry = UITapGestureRecognizer(target: self, action: #selector(self.angryImageView_touchUpInside))
        angryImageView.addGestureRecognizer(tapGestureForangry)
        angryImageView.isUserInteractionEnabled = true
        let tapGestureForCool = UITapGestureRecognizer(target: self, action: #selector(self.coolImageView_touchUpInside))
        coolImageView.addGestureRecognizer(tapGestureForCool)
        coolImageView.isUserInteractionEnabled = true
        let tapGestureForBoring = UITapGestureRecognizer(target: self, action: #selector(self.boringImageView_touchUpInside))
        boringImageView.addGestureRecognizer(tapGestureForBoring)
        boringImageView.isUserInteractionEnabled = true
        let tapGestureForLable = UITapGestureRecognizer(target: self, action: #selector(self.nameLable_touchUpInside))
        nameLable.addGestureRecognizer(tapGestureForLable)
        nameLable.isUserInteractionEnabled = true
    }
//    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
//    {
//                self.backView.frame.size.height = 360
//        self.backView.clipsToBounds = true
//        // Your action
//    }
    
    @objc func nameLable_touchUpInside(){
        if let id = user?.id {
            delegate?.goToProfileUserVC(userId: id)
            
        }
    }
    
     @objc func happyImageView_touchUpInside(){
        postRef = Api.Post.REF_POSTS.child(post!.id!)
        incrementHappy(forRef: postRef)
        sadImageView.isUserInteractionEnabled = false
        angryImageView.isUserInteractionEnabled = false
        coolImageView.isUserInteractionEnabled = false
        boringImageView.isUserInteractionEnabled = false
        
    }
    @objc func sadImageView_touchUpInside(){
        postRef = Api.Post.REF_POSTS.child(post!.id!)
        incrementSad(forRef: postRef)
        happyImageView.isUserInteractionEnabled = false
        angryImageView.isUserInteractionEnabled = false
        coolImageView.isUserInteractionEnabled = false
        boringImageView.isUserInteractionEnabled = false
    }
    @objc func angryImageView_touchUpInside(){
        postRef = Api.Post.REF_POSTS.child(post!.id!)
        incrementAngry(forRef: postRef)
        happyImageView.isUserInteractionEnabled = false
        sadImageView.isUserInteractionEnabled = false
        coolImageView.isUserInteractionEnabled = false
        boringImageView.isUserInteractionEnabled = false
    }
    @objc func coolImageView_touchUpInside(){
        postRef = Api.Post.REF_POSTS.child(post!.id!)
        incrementCool(forRef: postRef)
        happyImageView.isUserInteractionEnabled = false
        sadImageView.isUserInteractionEnabled = false
        angryImageView.isUserInteractionEnabled = false
        boringImageView.isUserInteractionEnabled = false
    }
    @objc func boringImageView_touchUpInside(){
        postRef = Api.Post.REF_POSTS.child(post!.id!)
        incrementBoring(forRef: postRef)
        happyImageView.isUserInteractionEnabled = false
        sadImageView.isUserInteractionEnabled = false
        angryImageView.isUserInteractionEnabled = false
        coolImageView.isUserInteractionEnabled = false
    }
//    BORING
    func incrementBoring(forRef ref : DatabaseReference) {
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
                var boring: Dictionary<String, Bool>
                boring = post["boring"] as? [String : Bool] ?? [:]
                var boringCount = post["boringCount"] as? Int ?? 0
                if let _ = boring[uid] {
                    // Unstar the post and remove self from stars
                    boringCount -= 1
                    boring.removeValue(forKey: uid)
                } else {
                    // Star the post and add self to stars
                    boringCount += 1
                    boring[uid] = true
                }
                post["boringCount"] = boringCount as AnyObject?
                post["boring"] = boring as AnyObject?
                
                // Set value and report transaction success
                currentData.value = post
                
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let dict = snapshot?.value as? [String: Any]{
                let post = Post.trasformPostPhoto(dict: dict, key: snapshot!.key)
                self.updateBoring(post: post)
            }
        }
    }
//    COOL
    func incrementCool(forRef ref : DatabaseReference) {
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
                var cool: Dictionary<String, Bool>
                cool = post["cool"] as? [String : Bool] ?? [:]
                var coolCount = post["coolCount"] as? Int ?? 0
                if let _ = cool[uid] {
                    // Unstar the post and remove self from stars
                    coolCount -= 1
                    cool.removeValue(forKey: uid)
                } else {
                    // Star the post and add self to stars
                    coolCount += 1
                    cool[uid] = true
                }
                post["coolCount"] = coolCount as AnyObject?
                post["cool"] = cool as AnyObject?
                
                // Set value and report transaction success
                currentData.value = post
                
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let dict = snapshot?.value as? [String: Any]{
                let post = Post.trasformPostPhoto(dict: dict, key: snapshot!.key)
                self.updateCool(post: post)
            }
        }
    }
//    ANGRY
    func incrementAngry(forRef ref : DatabaseReference) {
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
                var angry: Dictionary<String, Bool>
                angry = post["angry"] as? [String : Bool] ?? [:]
                var angryCount = post["angryCount"] as? Int ?? 0
                if let _ = angry[uid] {
                    // Unstar the post and remove self from stars
                    angryCount -= 1
                    angry.removeValue(forKey: uid)
                } else {
                    // Star the post and add self to stars
                    angryCount += 1
                    angry[uid] = true
                }
                post["angryCount"] = angryCount as AnyObject?
                post["angry"] = angry as AnyObject?
                
                // Set value and report transaction success
                currentData.value = post
                
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let dict = snapshot?.value as? [String: Any]{
                let post = Post.trasformPostPhoto(dict: dict, key: snapshot!.key)
                self.updateAngry(post: post)
            }
        }
    }
//    SAD
    func incrementSad(forRef ref : DatabaseReference) {
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
                var sad: Dictionary<String, Bool>
                sad = post["sad"] as? [String : Bool] ?? [:]
                var sadCount = post["sadCount"] as? Int ?? 0
                if let _ = sad[uid] {
                    // Unstar the post and remove self from stars
                    sadCount -= 1
                    sad.removeValue(forKey: uid)
                } else {
                    // Star the post and add self to stars
                    sadCount += 1
                    sad[uid] = true
                }
                post["sadCount"] = sadCount as AnyObject?
                post["sad"] = sad as AnyObject?
                
                // Set value and report transaction success
                currentData.value = post
                
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let dict = snapshot?.value as? [String: Any]{
                let post = Post.trasformPostPhoto(dict: dict, key: snapshot!.key)
                self.updateSad(post: post)
            }
        }
    }
//    HAPPY
    func incrementHappy(forRef ref : DatabaseReference) {
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
                var happy: Dictionary<String, Bool>
                happy = post["happy"] as? [String : Bool] ?? [:]
                var happyCount = post["happyCount"] as? Int ?? 0
                if let _ = happy[uid] {
                    // Unstar the post and remove self from stars
                    happyCount -= 1
                    happy.removeValue(forKey: uid)
                } else {
                    // Star the post and add self to stars
                    happyCount += 1
                    happy[uid] = true
                }
                post["happyCount"] = happyCount as AnyObject?
                post["happy"] = happy as AnyObject?
                
                // Set value and report transaction success
                currentData.value = post
                
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let dict = snapshot?.value as? [String: Any]{
                let post = Post.trasformPostPhoto(dict: dict, key: snapshot!.key)
                self.updateHappy(post: post)
            }
        }
    }
    

    @objc func commentImageView_touchUpInside() {
        print("commentImageView_touchUpInside")
        if let id = post?.id {
            delegate?.goToCommentVC(postId: id)
            
        }
    }
    
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("123456")
        profileImageView.image = UIImage(named: "profiledefault")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

