//
//  TableViewCell.swift
//  ViewAnimator_OpenSource
//
//  Created by 홍진석 on 2021/02/15.
//

import UIKit

class TableViewCell: UITableViewCell {

    var delegate : CellDelegate?
    var index : Int?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        heartBtn.isSelected = false
        label.font = .boldSystemFont(ofSize: 16)
        heartBtn.setImage(Heart.normalImage, for: .normal)
    }
    
    var isHeart : Bool = false{
        willSet(newValue){
            if isHeart != newValue{
                //Heart.animated(btn: heartBtn)
            }
        }
    }
    
    @IBAction func heartBtnClicked(_ sender: UIButton) {
        guard let idx = index else{return}
        sender.isSelected = !sender.isSelected

        if sender.isSelected {
            print("selected")
            isHeart = true
            delegate?.clickHeart(for: idx, like: isHeart)
        }
        else{
            print("deselected")
            isHeart = false
            delegate?.clickHeart(for: idx, like: isHeart)
            
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
       // super.setSelected(selected, animated: animated)
    }
    
}
