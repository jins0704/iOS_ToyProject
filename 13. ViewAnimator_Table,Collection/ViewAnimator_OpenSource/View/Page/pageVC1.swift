//
//  pageVC1.swift
//  ViewAnimator_OpenSource
//
//  Created by 홍진석 on 2021/06/25.
//

import UIKit

class pageVC1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("pageVC1 ... viewDidLoad")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("pageVC1 ... videDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("pageVC1 ... videDidDisappear")
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
