//
//  Heart.swift
//  ViewAnimator_OpenSource
//
//  Created by 홍진석 on 2021/02/23.
//

import Foundation
import UIKit

protocol CellDelegate{
    func clickHeart(for index : Int, like : Bool)
}

struct Heart{
    
    var heartBtn : UIButton?
    
    static let activatedImage = UIImage(systemName: "heart.fill")?.withTintColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)).withRenderingMode(.alwaysOriginal)
    static let normalImage =  UIImage(systemName: "heart")?.withTintColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)).withRenderingMode(.alwaysOriginal)
    
    func animated(btn : UIButton){
        UIView.animate(withDuration: 0.1) {
            //작아지는 애니메이션
            btn.transform = btn.transform.scaledBy(x: 0.5, y: 0.5)
            btn.setImage(Heart.isHeart ? Heart.normalImage : Heart.activatedmage, for: .normal)

        } completion: { _ in

            //원래대로 돌아오기
            UIView.animate(withDuration: 0.1) {
                btn.transform = CGAffineTransform.identity
            }
        }
    }
}
