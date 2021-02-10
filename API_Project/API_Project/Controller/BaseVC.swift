//
//  BaseVC.swift
//  API_Project
//
//  Created by 홍진석 on 2021/02/09.
//

import UIKit
import Toast_Swift

class BaseVC: UIViewController {
    
    var vcTitle : String = "" {
        didSet {
            self.title = vcTitle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //등록
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorPopup(notification:)), name: NSNotification.Name(rawValue:NOTIFICATION.API.AUTH_FAIL), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //인증 실패 해제
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:NOTIFICATION.API.AUTH_FAIL), object: nil)
    }
    
    //노티피케이션 알림 메소드
    @objc func showErrorPopup(notification:NSNotification){
        print("error popup")
        
        if let data = notification.userInfo?["statusCode"]{
            
            DispatchQueue.main.async {
                self.view.makeToast("\(data) 에러", duration: 3.0, position: .center)
            }
            
            print("shoow errorpopup \(data)")
        }
    }
}
