//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var calculatingbrain = CalculatingBrain()
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        
        heightLabel.text = "\(String(format: "%.2f", sender.value))m"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
         weightLabel.text = "\(String(format: "%.0f", sender.value))kg"
    }
    
    
    @IBAction func calculateChange(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value
        
        calculatingbrain.calculatingBMI(height : height, weight : weight)
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let dest = segue.destination as! ResultViewController
            dest.bmiValue = calculatingbrain.getBMIValue()
            dest.advice = calculatingbrain.getAdvice()
            dest.color = calculatingbrain.getColor()
        }
    }
    
}

