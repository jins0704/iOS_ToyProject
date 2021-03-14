//
//  CollectionViewCell.swift
//  ViewAnimator_OpenSource
//
//  Created by 홍진석 on 2021/03/13.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TabBarCell"
    @IBOutlet weak var titleLavel : UILabel!
    
    func setTitle(title : String){
        titleLabel.text = title
    }
    
    override var isSelected : Bool{
        willSet{
            if newValue{
                titleLabel.textColor = .black
            }
            else{
                titleLabel.textColor = .lightGray
            }
        }
    }
    
    override func prepareForReuse(){
        isSelected = false
    }
}
