//
//  CenterPageVC.swift
//  ViewAnimator_OpenSource
//
//  Created by 홍진석 on 2021/06/25.
//

import UIKit

class CenterPageVC: UIViewController {

    var pageController : pageControl?
//    var currentIndex : Int = 0 {
//         didSet{
//             print(currentIndex)
//         }
//     }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageSegue"{
            print("connected")
            guard let vc = segue.destination as? pageControl else{
                print("no dest")
                return}
            pageController = vc
//          pageController?.completeHandler = { (result) in
//                print(result)
//                self.currentIndex = result
//            }
        }
    }
    
    @IBAction func redBtnClicked(_ sender: Any) {
        pageController?.setViewControllerFromIndex(index: 0)
    }
    @IBAction func blueBtnClicked(_ sender: Any) {
        pageController?.setViewControllerFromIndex(index: 1)
    }
    @IBAction func yellowBtnClicked(_ sender: Any) {
        pageController?.setViewControllerFromIndex(index: 2)
    }
    
}
