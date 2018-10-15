//
//  GitHubSearchParameter.swift
//  RxExample
//
//  Created by Naraki on 10/11/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import Foundation

struct GitHubSearchParameter: Codable {
    struct Query: Codable {
        let language: [String]?
        let topic: [String]?
    }
    enum Sort: String, Codable {
        case stars
        case forks
        case updated
    }
    enum Order: String, Codable {
        case desc
        case asc
    }

    let q: Query
    let sort: Sort
    let order: Order

    init(languages: [String]? = nil, topics: [String]? = nil, sort: Sort = .stars, order: Order = .desc) {
        self.q = Query(language: languages ?? ["Swift"], topic: topics)
        self.sort = sort
        self.order = order
    }

    var queryString: String {
        let language = q.language?.compactMap { $0 }.map { "language:\($0)" }.joined(separator: "+")
        let topic = q.topic?.compactMap { $0 }.map { "topic:\($0)" }.joined(separator: "+")
        let query = [language, topic].compactMap { $0 }.joined(separator: "+")
        return ["q": query, "sort": sort.rawValue, "order": order.rawValue]
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
    }
}
