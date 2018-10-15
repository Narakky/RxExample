//
//  Int+.swift
//  RxExample
//
//  Created by Naraki on 10/15/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import Foundation

extension Int {

    var decimalCommaString: String {
        let num = NSNumber(value: self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3

        guard let decimalCommaString = formatter.string(from: num) else {
            return self.description
        }
        return decimalCommaString
    }

}
