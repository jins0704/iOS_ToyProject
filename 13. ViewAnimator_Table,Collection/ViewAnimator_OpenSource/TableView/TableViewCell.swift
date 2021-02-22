//
//  TableViewCell.swift
//  ViewAnimator_OpenSource
//
//  Created by 홍진석 on 2021/02/15.
//

import UIKit

protocol CellDelegate{
    func clickHeart(for index : Int, like : Bool)
}

class TableViewCell: UITableViewCell {

    var delegate : CellDelegate?
    var index : Int?
    
    let activatedImage = UIImage(systemName: "heart.fill")?.withTintColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)).withRenderingMode(.alwaysOriginal)
    let normalImage =  UIImage(systemName: "heart")?.withTintColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)).withRenderingMode(.alwaysOriginal)

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        heartBtn.isSelected = false
        label.font = .boldSystemFont(ofSize: 16)
        heartBtn.setImage(normalImage, for: .normal)
    }
    
    var isHeart : Bool = false{
        willSet(newValue){
            if isHeart != newValue{
                print("\(isHeart) -> \(newValue)")
                animated(btn: heartBtn)
            }
        }
    }
    
    
    @IBAction func heartBtnClicked(_ sender: UIButton) {
        guard let idx = index else{return}
        sender.isSelected = !sender.isSelected
        
        //self.isHeart.toggle()
        
        //animated(btn: heartBtn)
        
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
    
    func animated(btn : UIButton){
        UIView.animate(withDuration: 0.1) {
            //작아지는 애니메이션
            btn.transform = btn.transform.scaledBy(x: 0.5, y: 0.5)
            btn.setImage(self.isHeart ? self.normalImage : self.activatedImage, for: .normal)

        } completion: { _ in

            //원래대로 돌아오기
            UIView.animate(withDuration: 0.1) {
                btn.transform = CGAffineTransform.identity
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
       // super.setSelected(selected, animated: animated)
    }
    
}
