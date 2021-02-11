//
//  AlamofireManager.swift
//  API_Project
//
//  Created by 홍진석 on 2021/02/10.
//

import Foundation
import Alamofire
import SwiftyJSON

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
    
    func getPhotos(searchTerm userInput : String, completion : @escaping(Result<[Photo], MyError>) -> Void){
        
        self.session
            .request(SearchRouter.SearchPhotos(terms: userInput))
            .validate(statusCode: 200..<401)
            .responseJSON { (response) in
                print("파싱하기")
                guard let responseValue = response.value else{return}
                
                let responseJson = JSON(responseValue)
               
                let jsonArray = responseJson["results"]
                
                var photos = [Photo]()
                
                for (_, subJson): (String,JSON) in jsonArray{
                    
                    //데이터 파싱
                    guard let thumbnail = subJson["urls"]["thumb"].string,
                          let username = subJson["user"]["username"].string,
                          let createdAt = subJson["created_at"].string else{return}
                    
                    let likesCount = subJson["likes"].intValue
                    
                    let photoItem = Photo(thumbnial: thumbnail, username: username, likeCount: likesCount, createdAt: createdAt )
                    //배열 넣기
                    photos.append(photoItem)
                }
                
                if photos.count > 0{
                    completion(.success(photos))
                }else{
                    completion(.failure(.noContetnt))
                }
            }
    }
}
