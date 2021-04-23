//
//  PostDetailTableViewCell.swift
//  instagramImitation
//
//  Created by Betty Pan on 2021/4/22.
//

import UIKit

class PostDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userAcountLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likedBtn: UIButton!
    @IBOutlet weak var likedCountLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var isLiked = false
    func setLikeBtn() {
        if isLiked {
            likedBtn.setImage(UIImage(named: "fill1"), for: .normal)
            isLiked = false
        }else{
            likedBtn.setImage(UIImage(named: "iconLove"), for: .normal)
            isLiked = true
        }
    }
    
    @IBAction func likePost(_ sender: Any) {
        setLikeBtn()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
