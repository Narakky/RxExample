//
//  Encodable+.swift
//  RxExample
//
//  Created by Naraki on 10/12/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            .flatMap { $0 as? [String: Any] }
    }
}
