//
//  ThirdViewController.swift
//  LottieAnimation
//
//  Created by 홍진석 on 2021/02/04.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func FlipL(_ sender: Any) {
        UIView.transition(with: self.myView, duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    @IBAction func FlipR(_ sender: Any) {
        UIView.transition(with: self.myView, duration: 1, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    @IBAction func CurlD(_ sender: Any) {
        UIView.transition(with: self.myView, duration: 1, options: .transitionCurlDown, animations: nil, completion: nil)
    }
    
    @IBAction func CurlU(_ sender: Any) {
        UIView.transition(with: self.myView, duration: 1, options: .transitionCurlUp, animations: nil, completion: nil)
    }
    
    @IBAction func FlipT(_ sender: Any) {
        UIView.transition(with: self.myView, duration: 1, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    @IBAction func FlipB(_ sender: Any) {
        UIView.transition(with: self.myView, duration: 1, options: .transitionFlipFromBottom, animations: nil, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
