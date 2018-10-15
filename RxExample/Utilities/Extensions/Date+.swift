//
//  Date+.swift
//  RxExample
//
//  Created by Naraki on 10/15/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import Foundation

extension Date {
    var formattedDateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.string(from: self)
    }
}
