//
//  ViewController.swift
//  Mojito
//
//  Created by 홍진석 on 2021/07/26.
//

import UIKit
import CoreMotion
import Then
import SnapKit

class ViewController: UIViewController {
    lazy var circle = UIView().then {
        $0.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.drag))
        $0.addGestureRecognizer(panGesture)
    }
    var centerX = UIScreen.main.bounds.width*0.5
    var centerY = UIScreen.main.bounds.height*0.5
    let cmManager = CMMotionManager()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .brown
        makeCircle()
        wiggle()
        moveCircleByAccelerate()
    }
    
    func makeCircle(){
        circle.frame = CGRect(x: 50, y: 80, width: 50, height: 50)
        circle.layer.backgroundColor = UIColor.red.cgColor
        circle.layer.cornerRadius = circle.frame.height/2
        self.view.addSubview(circle)
        
        print(circle.frame.width)
        print(circle.frame.height)
        print(circle.frame)
    }
    
    func wiggle(){
        let scaleDelta = CGFloat(0.30)
        let wiggleOutHorizontally = CGAffineTransform(scaleX: 1.0 + scaleDelta, y: 1.0)
        let wiggleOutVertically = CGAffineTransform(scaleX: 1.0, y: 1.0 + scaleDelta)
        UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
            // Animate wiggle horizontally
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.circle.transform = wiggleOutHorizontally
            })
            
            // Animate wiggle vertically
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.circle.transform = wiggleOutVertically
            })
            
//            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
//                self.circle.transform = CGAffineTransform(translationX: -30, y: -30)
//            })
        },
        completion: nil)
    }
    
    func moveCircleByAccelerate(){
        if cmManager.isAccelerometerAvailable {
            cmManager.accelerometerUpdateInterval = 1.0
            cmManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { (accelerometer, error) -> Void in
                print(accelerometer?.acceleration ?? 0)
                //가속도에 따라 공 움직이기
            })
        }
    }
    
    @objc func drag(sender: UIPanGestureRecognizer) {
        print("catch!")
        // self는 여기서 ViewController이므로 self.view ViewController가 기존에가지고 있는 view이다.
        let translation = sender.translation(in: self.view) // translation에 움직인 위치를 저장한다.
        
        // sender의 view는 sender가 바라보고 있는 circleView이다. 드래그로 이동한 만큼 circleView를 이동시킨다.
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        sender.setTranslation(.zero, in: self.view) // 0으로 움직인 값을 초기화 시켜준다.
    }
}

