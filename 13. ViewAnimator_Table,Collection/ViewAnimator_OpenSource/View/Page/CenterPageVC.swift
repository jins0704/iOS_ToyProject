//
//  CenterPageVC.swift
//  ViewAnimator_OpenSource
//
//  Created by 홍진석 on 2021/06/25.
//

import UIKit

class CenterPageVC: UIPageViewController {

    var pageController : pageControl!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageSegue"{
            if segue.destination.isKind(of: pageControl.self){
                pageController = segue.destination as? pageControl
            }
        }
    }
    @IBAction func redBtnClicked(_ sender: Any) {
        pageController.setViewControllerFromIndex(index: 0)
    }
    @IBAction func blueBtnClicked(_ sender: Any) {
        pageController.setViewControllerFromIndex(index: 1)
    }
    @IBAction func yellowBtnClicked(_ sender: Any) {
        pageController.setViewControllerFromIndex(index: 2)
    }
    
}
