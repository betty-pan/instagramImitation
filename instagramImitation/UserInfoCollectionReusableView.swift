//
//  UserInfoCollectionReusableView.swift
//  instagramImitation
//
//  Created by Betty Pan on 2021/4/20.
//

import UIKit

class UserInfoCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var userAcountLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UITextView!
    
    @IBOutlet var btns: [UIButton]!
    }
