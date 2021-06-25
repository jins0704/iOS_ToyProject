//
//  pageControl.swift
//  ViewAnimator_OpenSource
//
//  Created by 홍진석 on 2021/06/25.
//

import UIKit

class pageControl: UIPageViewController {

    lazy var viewsList : [UIViewController] = {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
           
            let vc1 = storyBoard.instantiateViewController(withIdentifier: "pageVC1")
            let vc2 = storyBoard.instantiateViewController(withIdentifier: "pageVC2")
            let vc3 = storyBoard.instantiateViewController(withIdentifier: "pageVC3")
            
            return [vc1, vc2, vc3]
            
        }()
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        
//        self.dataSource = self
//        self.delegate = self
//        
        setViewControllerFromIndex(index: 0)
    }
    
    func setViewControllerFromIndex(index : Int){
        self.setViewControllers([viewsList[index]], direction: .forward, animated: true, completion: nil)
    }
}
//
//extension pageControl : UIPageViewControllerDelegate{
//    func presentationCount(for pageViewController: UIPageViewController) -> Int{
//        return viewsList.count
//    }
//}
//extension pageControl : UIPageViewControllerDataSource{
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//
//        guard let index = viewsList.firstIndex(of: viewController) else {return nil}
//
//        if index < 1 { return nil}
//
//        return viewsList[index-1]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let index = viewsList.firstIndex(of: viewController) else {return nil}
//
//        if index == viewsList.count-1 { return nil}
//
//        return viewsList[index+1]
//    }
//
//
//}
