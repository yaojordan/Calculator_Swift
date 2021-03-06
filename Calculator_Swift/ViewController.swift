//
//  ViewController.swift
//  Calculator_Swift
//
//  Created by 姚宇鴻 on 2017/3/12.
//  Copyright © 2017年 JordanYao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsTyping = false
    
    @IBAction func tapDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping{
            let  textCurrentInDisplay = display.text!
            display.text = textCurrentInDisplay + digit
        }
        else{
            display.text = digit
            userIsTyping = true
        }
    }
    
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTyping{
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        if let mathmeticalSymbol = sender.currentTitle{
            brain.performOperation(mathmeticalSymbol)
        }
        if let result = brain.result{
            displayValue = result
        }
    }
    
    

}

