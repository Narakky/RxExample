//
//  GitHubAPIEndpoints.swift
//  RxExample
//
//  Created by Naraki on 10/11/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import Foundation
import Moya

protocol GitHubAPITargetType: APITargetType {
    var parameter: Parameter { get }
}
extension GitHubAPITargetType {
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    var headers: [String : String]? { return ["Content-Type": "application/json"] }
}

enum GitHubAPIEndpoints {

    static var authorizationParameter: String {
        let clientID = Configuration.shared.apiClientID
        let clientSecret = Configuration.shared.apiClientSecret
        return "client_id=\(clientID)&client_secret=\(clientSecret)"
    }

    struct search: GitHubAPITargetType {
        typealias Parameter = GitHubSearchParameter
        typealias Response = GitHubSearchResult

        var parameter: GitHubSearchParameter
        var baseURL: URL {
            return URL(string: "https://api.github.com?\(GitHubAPIEndpoints.authorizationParameter)&\(parameter.queryString)")!
        }
        var path: String { return "/search/repositories" }
        var method: Moya.Method { return .get }
        var sampleData: Data { return Data() }
        var task: Task { return .requestPlain }
    }

}
