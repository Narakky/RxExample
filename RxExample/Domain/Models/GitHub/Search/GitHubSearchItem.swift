//
//  GitHubSearchItem.swift
//  RxExample
//
//  Created by Naraki on 10/11/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import Foundation

struct GitHubSearchItem: Codable {
    let id: Int
    let nodeId: String
    let name: String
    let fullName: String
    let `private`: Bool
    let owner: GitHubSearchItemOwner
    let htmlUrl: String
    let description: String?
    let url: String
    let createdAt: Date
    let updatedAt: Date
    let pushedAt: Date
    let size: Int
    let stargazersCount: Int
    let watchersCount: Int
    let language: String?
    let hasIssues: Bool
    let forksCount: Int
    let openIssuesCount: Int
}
