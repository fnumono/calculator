//
//  Calculation.swift
//  ImproveCalculator
//
//  Created by pramono wang on 2/11/16.
//  Copyright © 2016 ucla. All rights reserved.
//


//single case
//precedence of ^

import Foundation


class Calculation{
    
    func conjugate(item: String) -> String {
        if item == ")" {
            return "("
        } else if item == "]" {
            return "["
        } else {
            return "{"
        }
    }
    
    
     func checkTheEvaluation(equation: [String]) -> Bool {
   
        
        var stack: [String] = []
        var isNumber: Bool = false
        var counter = 0
        
        for item in equation {
            print(item)
            switch item {
            case "{", "(", "[":
                stack.append(item)
                isNumber =  false
            case "}", "]", ")":
                if  !stack.isEmpty && (stack.last! == conjugate(item)) {
                    stack.removeLast()
                    isNumber = false
                } else {
                    return false
                }
            case "+", "-", "*", "/", "%", "^":
                isNumber = false
                counter--
                
                continue
            default:
                if isNumber == true {
                    return false
                } else {
                    isNumber = true
                    counter++
                }
            }
        }
        
        if (counter != 1){
            return false
        }
        return true

    }
    
    func infixToPostfixEvaluation(equation: [String]) -> [String] {
        var result: [String] = []
        var stack: [String] = []
        //let stack: Stack = Stack<Character>(size: equation.characters.count)
        
        for str in equation {
            switch str {
            case "+", "-","^", "%", "*", "/", "⎷":
                if str == "-" || str == "+" {
                    if stack.isEmpty {
                        stack.append(str)
                    } else {
                        switch stack.last! {
                        case "+", "-", "/", "*", "^", "%", "⎷":
                            while !stack.isEmpty && (stack.last! == "+" || stack.last! == "-" || stack.last! == "^" || stack.last! == "%" || stack.last! == "*" || stack.last! == "/" || stack.last! == "⎷")  {
                                result.append(stack.removeLast())                           }
                            stack.append(str)
                        default:
                            stack.append(str)
                            
                        }
                    }
                } else {
                    if stack.isEmpty {
                        stack.append(str)
                    } else {
                        switch stack.last! {
                        case "*", "/", "%", "^":
                            while (stack.last! == "*" || stack.last! == "/" || stack.last! == "%" || stack.last! == "^") && !stack.isEmpty {
                                result.append(stack.removeLast())
                            }
                            stack.append(str)
                        default:
                            stack.append(str)
                        }
                    }
                }
            case "(", "{", "[":
                stack.append(str)
            case ")", "}", "]":
                while stack.last != "(" && stack.last != "{" && stack.last != "[" && !stack.isEmpty {
                    result.append(stack.removeLast())
                }
                stack.removeLast()
            case "⎷":
                stack.append(str)
            default:
                // its a number.
                result.append(str)
            }
        }
        while !stack.isEmpty {
            if stack.last! == "(" || stack.last! == "{" || stack.last! == "[" {
                stack.removeLast()
            } else {
                result.append(stack.removeLast())
            }
        }
        
        return result
    }
    
    
    func postfixEvaluate(equation: [String]) -> Double {
        var result:Double = 0.0
        var stack: [Double] = []
        
        for item in equation {
            print(item)
            if item == "+" {
                if stack.count >= 2 {
                    let val2: Double = stack.removeLast()
                    let val1: Double = stack.removeLast()
                    result = val1 + val2
                    stack.append(result)
                }
//                else if stack.count == 1{
//                    let val2 = stack.removeLast()
//                    let val1 = val2
//                    result = val1 + val2
//                    stack.append(result)
//                }
            } else if item == "-" {
                if !stack.isEmpty{
                    let val2 = stack.removeLast()
                    let val1 = stack.removeLast()
                    result = val1 - val2
                    stack.append(result)
                }
            } else if item == "*" {
                if !stack.isEmpty {
                    let val2 = stack.removeLast()
                    let val1 = stack.removeLast()
                    result = val1 * val2
                    stack.append(result)
                }
            } else if item == "/" {
                if !stack.isEmpty {
                    let val2 = stack.removeLast()
                    let val1 = stack.removeLast()
                    result = val1 / val2
                    stack.append(result)
                }
              
            }
            else if item == "^" {
                if !stack.isEmpty {
                    let val2 = stack.removeLast()
                    let val1 = stack.removeLast()
                    result = pow(val1, val2)
                    stack.append(result)
                }
            }
            else if item == "⎷" {
                if !stack.isEmpty {
                    let val2 = stack.removeLast()
                    result = sqrt(val2)
                    stack.append(result)
                }
            }
            else if item == "%" {
                if !stack.isEmpty {
                    let val2 = stack.removeLast()
                    let val1 = stack.removeLast()
                    result = val1 % val2
                    stack.append(result)
                }
                }
            else {
                stack.append(Double(item)!)
            }
        }
        
        return result
    }
}