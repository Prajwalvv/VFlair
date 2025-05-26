//
//  photoCollectionViewCell.swift
//  vFlair
//
//  Created by splash on 01/03/19.
//  Copyright © 2019 fluid. All rights reserved.
//

import UIKit

class photoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    
    var post: Post?{
        didSet {
            updateView()
        }
    }
    func updateView(){
        if let photoUrlString = post?.photoUrl{
            let photoUrl = URL(string: photoUrlString)
          photo.sd_setImage(with: photoUrl)
        }
    }
    override func awakeFromNib() {
       photo.layer.cornerRadius = photo.frame.size.width / 6
        photo.clipsToBounds = true
    }
}
