//
//  CollectionViewCell.swift
//  ViewAnimator_OpenSource
//
//  Created by 홍진석 on 2021/02/15.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    
    var isHeart : Bool = false{
        willSet(newValue){
            if isHeart != newValue{
                //animated(btn: heartBtn)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        heartBtn.isSelected = false
        label.font = .boldSystemFont(ofSize: 16)
        heartBtn.setImage(Heart.normalImage, for: .normal)
    }

}
