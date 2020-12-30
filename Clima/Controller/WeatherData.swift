//
//  WeatherData.swift
//  Clima
//
//  Created by 홍진석 on 2020/08/12.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Codable{
    let name : String
    let main : Main 
    let weather : [Weather]
}
struct Main : Codable{
    let temp  : Double
}
struct Weather : Codable {
    let description : String
    let id : Int
}
