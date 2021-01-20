//
//  CalculatingBrain.swift
//  BMI Calculator
//
//  Created by 홍진석 on 2020/08/09.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatingBrain {
    
    var BMI : Bmi?
    
    mutating func calculatingBMI(height : Float, weight : Float){
        let bmivalue = weight / (height*height)
        
        if bmivalue < 18.5 {
            BMI = Bmi(value: bmivalue, advice: "You should eat!", color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
        }else if bmivalue < 24.9{
            BMI = Bmi(value: bmivalue, advice: "You are healthy", color: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        }else {
            BMI = Bmi(value: bmivalue, advice: "Stop eatting!!!", color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        }
    }
    
    func getBMIValue()->String{
        let getValue = String(format: "%.1f", BMI?.value ?? 0.0)
        return getValue
    }
    
    func getAdvice()-> String{
        let getAdvice = String(BMI?.advice ?? "Nothing")
        return getAdvice
    }
    
    func getColor()-> UIColor{
        let getColor = BMI?.color ?? .black
        return getColor
    }
}
