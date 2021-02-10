//
//  MyLogger.swift
//  API_Project
//
//  Created by 홍진석 on 2021/02/10.
//

import Foundation
import Alamofire

final class MyLogger : EventMonitor{
    let queue = DispatchQueue(label: "APIlog")
    
    func requestDidResume(_ request: Request) {
        print("MyLogger-reqeustDidResume")
        debugPrint(request)
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        print("MyLogger-didParseResponse")
        debugPrint(response)
    }
}
