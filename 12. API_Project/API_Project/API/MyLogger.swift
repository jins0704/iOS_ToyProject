//
//  MyLogger.swift
//  API_Project
//
//  Created by 홍진석 on 2021/02/10.
//

import Foundation
import Alamofire

final class MyLogger : EventMonitor{
    func requestDidFinish(_ request: Request) {}
    func requestDidCancel(_ request: Request) {}
    func requestIsRetrying(_ request: Request) {}
    func requestDidSuspend(_ request: Request) {}
    func requestDidResume(_ request: Request) {
        print("reqeustDidResume")
    }
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        print("MyLogger-didParseResponse")
        debugPrint(response)
    }
}
