//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var numStart = false
    private var checkDot = true
    
    private var displayValue : Double{
        get{
            guard let number = Double(displayLabel.text!) else{
                fatalError("error")
            }
            
            return number
        }
        set{
            displayLabel.text = String(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calButtonPressed(_ sender: UIButton) {
        
        calculator.setNum(displayValue)
        numStart = false
        
        if let calMethod = sender.currentTitle{
            if let result =  calculator.calculate(myMethod: calMethod){
                displayValue = result
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
       
        if let myValue = sender.currentTitle{
            
            if numStart == false{
                if myValue == "."{
                    return
                }
                displayLabel.text = myValue
                numStart = true
                checkDot = true
            }
            else{
                
                if myValue == "."{
                    
//                    guard let currentDisplay = Double(displayLabel.text!) else{
//                        fatalError("error ...")
//                    }
//                    let isInt = floor(currentDisplay) == currentDisplay
//                    if !isInt{return}
                    
                    if !checkDot{
                        return
                    }
                    checkDot = false
                }
                displayLabel.text = displayLabel.text! + myValue
            }
        }
    }
}

