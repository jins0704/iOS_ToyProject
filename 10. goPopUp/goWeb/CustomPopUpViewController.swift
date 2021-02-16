//
//  CustomPopUpViewController.swift
//  goWeb
//
//  Created by 홍진석 on 2021/02/06.
//

import UIKit

class CustomPopUpViewController: UIViewController{
    
    var popupDelegate : PopUpDelegate?
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var moveButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var ContentView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        ContentView.layer.cornerRadius = 20
        moveButton.layer.cornerRadius = 10
        yellowButton.layer.cornerRadius = 10
        blueButton.layer.cornerRadius = 10
        
    }
    
    // MARK: - IBAction
    @IBAction func moveButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        popupDelegate?.moveButtonClicked()
    }
    
    @IBAction func yellowButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        popupDelegate?.yellowButtonClicked()
    }
    
    @IBAction func blueButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        popupDelegate?.blueButtonClicked()
    }
    
    @IBAction func backgroundButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Delegate
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
