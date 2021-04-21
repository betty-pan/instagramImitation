//
//  ImageCollectionViewCell.swift
//  instagramImitation
//
//  Created by Betty Pan on 2021/4/20.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var cellWidthConstraint: NSLayoutConstraint!
    
    //cell大小：實現一排3張正方形的照片，照片間的間距為 3，總共有 2 個間距
    let width = floor((UIScreen.main.bounds.width-3*2)/3)
    
    //storyboard 裡的cell產生時，它會先呼叫function awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        cellWidthConstraint?.constant = self.width
        
    }
}
