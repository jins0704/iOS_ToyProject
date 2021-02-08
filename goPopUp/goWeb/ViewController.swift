//
//  ViewController.swift
//  goWeb
//
//  Created by 홍진석 on 2021/02/06.
//

import UIKit
import WebKit

class ViewController: UIViewController, PopUpDelegate {

    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var popupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func popupButtonClicked(_ sender: UIButton) {
        //팝업 스토리보드 가져오기
        let storyboard = UIStoryboard.init(name: "PopUp", bundle: nil)
        //스토리보드 통해 팝업 컨트롤러 가져오기
        let popUpVC = storyboard.instantiateViewController(identifier: "PopUpVC") as! CustomPopUpViewController
        //팝업 효과 스타일 설정
        popUpVC.modalPresentationStyle = .overCurrentContext //덮어 보여주는 스타일
        popUpVC.modalTransitionStyle = .crossDissolve //스르르 사라지는 스타일
                
        popUpVC.popupDelegate = self
        self.present(popUpVC, animated: true, completion: nil)
    }
    
    @IBAction func completeButtonClicked(_ sender: Any) {
        myWebView.isHidden = true
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.isHidden = true
            self.popupButton.isHidden = false
        }
    }
    
    // MARK: - Delegate
    func moveButtonClicked() {
        popupButton.isHidden = true
        myWebView.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        let currentURL = URL(string: "https://www.youtube.com/?gl=KR")
        self.myWebView.load(URLRequest(url: currentURL!))
    }
    
    func yellowButtonClicked() {
        popupButton.isHidden = true
        myWebView.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        let currentURL = URL(string: "https://open.kakao.com/o/gykKSRVc")
        self.myWebView.load(URLRequest(url: currentURL!))
    }
    
    func blueButtonClicked() {
        popupButton.isHidden = true
        myWebView.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        let currentURL = URL(string: "https://www.google.com/")
        self.myWebView.load(URLRequest(url: currentURL!))
    }
    
}

