//
//  CalculatorBrain.swift
//  Calculator_Swift
//
//  Created by 姚宇鴻 on 2017/3/23.
//  Copyright © 2017年 JordanYao. All rights reserved.
//

import Foundation

/*func changeSign(operand: Double) -> Double{
    return -operand
}
func multiply(op1: Double, op2: Double) -> Double{
    return op1 * op2
}
*/

struct CalculatorBrain
{
    private var accumulator: Double?
    
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double)->Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> =
    [
    "π": Operation.constant(Double.pi),
    "e": Operation.constant(M_E),
    "√": Operation.unaryOperation(sqrt),
    "cos": Operation.unaryOperation(cos),
    "±": Operation.unaryOperation({ -$0 }),
    "×": Operation.binaryOperation({$0 * $1 }),
    "÷": Operation.binaryOperation({$0 / $1 }),
    "-": Operation.binaryOperation({$0 - $1 }),
    "+": Operation.binaryOperation({$0 + $1 }),
    "=": Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        
        if let Operation = operations[symbol]{
            
            switch Operation{
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil{
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation(){
        if pendingBinaryOperation != nil && accumulator != nil{
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation{
        let function:(Double,Double)->Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double)->Double{
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {//mutating可變的
        accumulator = operand
    }
    
    var result: Double? {
        get{
            return accumulator
        }
    }
    
}
