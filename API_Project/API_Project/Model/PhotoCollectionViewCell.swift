//
//  PhotoCollectionViewCell.swift
//  API_Project
//
//  Created by 홍진석 on 2021/02/13.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImg: UIImageView!
    @IBOutlet weak var photoUser: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    
    var isHeart : Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 30
    }
    
    @IBAction func heartBtnClicked(_ sender: UIButton) {
        animated(btn: heartBtn)
        self.isHeart.toggle()
     
    }
    
    func animated(btn : UIButton){
        let activatedImage = UIImage(systemName: "heart.fill")?.withTintColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)).withRenderingMode(.alwaysOriginal)
        let normalImage =  UIImage(systemName: "heart")?.withTintColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)).withRenderingMode(.alwaysOriginal)
        
        
        UIView.animate(withDuration: 0.1) {
            //작아지는 애니메이션
            btn.transform = btn.transform.scaledBy(x: 0.5, y: 0.5)
            btn.setImage(self.isHeart ? normalImage : activatedImage, for: .normal)
            
        } completion: { _ in
            
            //원래대로 돌아오기
            UIView.animate(withDuration: 0.1) {
                btn.transform = CGAffineTransform.identity
            }
        }
    }
}


