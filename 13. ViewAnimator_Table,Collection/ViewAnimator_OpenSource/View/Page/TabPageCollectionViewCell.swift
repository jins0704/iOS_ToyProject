//
//  TabPageCollectionViewCell.swift
//  ViewAnimator_OpenSource
//
//  Created by 홍진석 on 2021/03/13.
//

import UIKit

class TabPageCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TabPageCell"
    
    lazy var backColor : [UIColor] = [.lightGray,, .purple, .orange, .cyan, .magenta]
    
    func setColor(index : Int){
        self.backgroundColor = backColor[index]
    }
}
