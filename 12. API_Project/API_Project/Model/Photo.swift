//
//  Photo.swift
//  API_Project
//
//  Created by 홍진석 on 2021/02/11.
//

import Foundation

struct Photo : Codable {
    var thumbnial : String
    var username : String
    var likeCount : Int
    var createdAt : String
}
