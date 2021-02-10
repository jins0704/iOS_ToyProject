//
//  AlamofireManager.swift
//  API_Project
//
//  Created by 홍진석 on 2021/02/10.
//

import Foundation
import Alamofire

final class AlamofireManager{
    
    //singleton 적용
    static let shared = AlamofireManager()
    
    //인터셉터
    let interceptors = Interceptor(interceptors:
                                    [
                                        BaseInterceptor()
                                    ])
    
    //로거 설정
    let monitors = [MyLogger()]
    
    //세션 설정
    var session : Session
    
    private init(){
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
}
