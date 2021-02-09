//
//  BaseVC.swift
//  API_Project
//
//  Created by 홍진석 on 2021/02/09.
//

import UIKit

class BaseVC: UIViewController {
    
    var vcTitle : String = "" {
        didSet {
            self.title = vcTitle
        }
    }
}
