//
//  CalculatorLogic.swift
//  Calculator Layout iOS13
//
//  Created by 홍진석 on 2021/01/28.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
   
    private var number : Double?
    
    private var intermediateCalculation : (n1 : Double, calMethod : String)?

    mutating func setNum(_ number: Double){
        self.number = number
    }
    
    mutating func calculate(myMethod : String) -> Double?{
        
        if let n = number{
            if myMethod == "+/-"{
                return n * -1
            }
            else if myMethod == "%"{
                return n * 0.01
            }
            else if myMethod == "AC"{
                return 0
            }
            else if myMethod == "="{
                print(n)
                print(intermediateCalculation!.n1)
                print(intermediateCalculation!.calMethod)
                return performTwoNumCalulation(n2 : n)
            }
            else {
                intermediateCalculation = (n1: n, calMethod : myMethod)
            }
        }
        return 0
    }
    
    private func performTwoNumCalulation(n2 : Double) -> Double?{
      
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calMethod{
           
            switch operation{
            case "+" :
                return n1+n2
            case "-" :
                return n1-n2
            case "×" :
                return n1*n2
            case "÷" :
                return n1/n2
            default :
                fatalError("twocal error")
            }
        }
        return 0
    }
}
