//
//  CustomPopUpViewController.swift
//  goWeb
//
//  Created by 홍진석 on 2021/02/06.
//

import UIKit

class CustomPopUpViewController: UIViewController, PopUpDelegate {
    
    var popupDelegate : PopUpDelegate?
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var moveButton: UIButton!
    @IBOutlet weak var ContentView: UIView!
   
    var moveButtonCompletionClosure: (()-> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        ContentView.layer.cornerRadius = 20
        moveButton.layer.cornerRadius = 10
        
    }
    
    // MARK: - IBAction
    @IBAction func moveButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        //컴플레션 블럭 호출
        if let moveButtonCompletionClosure = moveButtonCompletionClosure{
            //메인에 알린다
            moveButtonCompletionClosure()
        }
    }
    
    @IBAction func yellowButtonClicked(_ sender: Any) {
    }
    
    @IBAction func blueButtonClicked(_ sender: Any) {
    }
    
    @IBAction func backgroundButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Delegate
    func yellowButtonClicked() {
        self.dismiss(animated: true, completion: nil)
        popupDelegate?.yellowButtonClicked()
    }
    
    func blueButtonClicked() {
        self.dismiss(animated: true, completion: nil)
        popupDelegate?.blueButtonClicked()
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
