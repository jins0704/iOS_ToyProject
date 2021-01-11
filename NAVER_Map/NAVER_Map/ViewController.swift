//
//  ViewController.swift
//  NAVER_Map
//
//  Created by 홍진석 on 2021/01/11.
//

import UIKit
import NMapsMap

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
        // Do any additional setup after loading the view.
    }


}

