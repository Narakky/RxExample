//
//  GitHubSearchResult.swift
//  RxExample
//
//  Created by Naraki on 10/11/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

struct GitHubSearchResult: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [GitHubSearchItem]
}
