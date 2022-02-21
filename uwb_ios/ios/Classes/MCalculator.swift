//
//  MCalculator.swift
//  uwb_ios
//
//  Created by Leroy on 16/02/2022.
//

import Foundation

public class MCalculatorHostApi{
    
    public static func setUp (binaryMessenger: FlutterBinaryMessenger) {
        let calculator = MCalculatorHostApi()
        
        let channel = FlutterMethodChannel(name: "com.baseflow.uwb/math_calculator", binaryMessenger: binaryMessenger)
        
        channel.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
              case "MCalculator.increment":
                print(calculator.increment(value: call.arguments as! Int))
                result(calculator.increment(value: call.arguments as! Int))
            default:
                result(FlutterMethodNotImplemented)
            }
         }
    }
    
    func increment(value: Int) -> Int{
        let newValue = value + 1
        return newValue
    }
}
