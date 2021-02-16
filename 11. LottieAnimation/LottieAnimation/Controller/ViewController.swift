//
//  ViewController.swift
//  LottieAnimation
//
//  Created by 홍진석 on 2021/02/04.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    let animationView : AnimationView = {
        let aniView = AnimationView(name: "23697-travelling-icon-animation")
    
        aniView.contentMode = .scaleAspectFill
        return aniView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.

        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animationView.center = view.center

        animationView.play{(finish) in
            
            self.animationView.removeFromSuperview()
            
            self.performSegue(withIdentifier: "gogo", sender: self)
          
        }
         
    }
}

