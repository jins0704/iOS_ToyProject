//
//  SearchRouter.swift
//  API_Project
//
//  Created by 홍진석 on 2021/02/10.
//

import Foundation
import Alamofire

//검색 관련 api
enum SearchRouter: URLRequestConvertible {
    case SearchPhotos(terms: String)
    case SearchUsers(terms: String)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL + "search")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .SearchPhotos: return .get
        case .SearchUsers: return .get
        }
    }
    
    var path: String {
        switch self {
        case .SearchPhotos: return "/photos"
        case .SearchUsers: return "/users"
        }
    }
    var parameters :[String:String]{
        
        switch self {
        case let .SearchPhotos(terms): return ["query": terms]
        case let .SearchUsers(terms): return ["query": terms]
        }
    }
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        
        request.method = method
        
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        
//        switch self {
//        case let .SearchPhoto(parameters):
//            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
//        case let .SearchUser(parameters):
//            request = try JSONParameterEncoder().encode(parameters, into: request)
//        }
        
        return request
    }
}
