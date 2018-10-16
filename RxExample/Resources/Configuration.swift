//
//  Configuration.swift
//  RxExample
//
//  Created by Naraki on 10/16/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import Foundation

enum Environment {
    case debug
    case staging
    case production
}

struct Configuration {

    // MARK: - Singleton

    static let shared = Configuration()

    // MARK: - Properties

    private let plist: [String: Any]!
//    private let configurationDirectoryPath: String = "Resources/Configuration"

    var env: Environment {
        #if DEBUG
        return .debug
        #elseif STAGING
        return .staging
        #else
        return .production
        #endif
    }

    var apiClientID: String {
        return plist["GitHub API Client ID"] as? String ?? ""
    }
    var apiClientSecret: String {
        return plist["GitHub API Client Secret"] as? String ?? ""
    }

    // MARK: - Initializer

    init() {
        #if DEBUG
        if let path = Bundle.main.path(forResource: "debug", ofType: "plist"),
        let plist = NSDictionary(contentsOfFile: path) as? [String: Any] {
            self.plist = plist
        } else {
            self.plist = [:]
        }
        #else
        self.plist = [:]
        #endif
    }
}
