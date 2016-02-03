//
//  FloatExtension.swift
//  TipCalculator
//
//  Created by vmalikov on 2/1/16.
//  Copyright © 2016 justForFun. All rights reserved.
//

import Foundation

extension Float {
    func formatWithDefaultValue() -> String {
        let defaultFormatForFloat = ".2"
        return format(defaultFormatForFloat)
    }
    
    func format(f: String) -> String {
        return NSString(format: "$%\(f)f", self) as String
    }
}