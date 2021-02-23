//
//  CommonViewController.swift
//  ViewAnimator_OpenSource
//
//  Created by 홍진석 on 2021/02/15.
//

import UIKit
import ViewAnimator

class CommonViewController: UIViewController {

    
    var arr : [cellNum] = []
    var newArr : [cellNum] = []
    
    let animations = [AnimationType.vector(CGVector(dx: 0, dy: 30))]
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arr.append(cellNum(num: "1", like: false))
        arr.append(cellNum(num: "2", like: false))
        arr.append(cellNum(num: "3", like: false))
        arr.append(cellNum(num: "4", like: false))
        arr.append(cellNum(num: "5", like: false))
        arr.append(cellNum(num: "6", like: false))
        arr.append(cellNum(num: "7", like: false))
        arr.append(cellNum(num: "8", like: false))
        arr.append(cellNum(num: "9", like: false))
        arr.append(cellNum(num: "10", like: false))
        arr.append(cellNum(num: "11", like: false))
        arr.append(cellNum(num: "12", like: false))
        arr.append(cellNum(num: "13", like: false))
        arr.append(cellNum(num: "14", like: false))
        arr.append(cellNum(num: "15", like: false))
        arr.append(cellNum(num: "16", like: false))
        arr.append(cellNum(num: "17", like: false))
        arr.append(cellNum(num: "18", like: false))
        arr.append(cellNum(num: "19", like: false))
        arr.append(cellNum(num: "29", like: false))

        //데이터 변경
        newArr = arr

        //테이블 뷰에 리프레시 컨트롤 달기
        refreshControl.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        let boldfont = UIFont.boldSystemFont(ofSize: 20)
        let attributes : [NSAttributedString.Key : Any] = [
            .font : boldfont,
            .foregroundColor : UIColor.init(cgColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        ]
        refreshControl.attributedTitle = NSAttributedString(string : "기다려요~", attributes: attributes)
        
    }
    
}
