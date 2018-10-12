//
//  GitHubSearchRepository.swift
//  RxExample
//
//  Created by Naraki on 10/11/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import Foundation
import RxSwift

protocol GitHubSearchRepositoryProtocol {
    func search(parameter: GitHubSearchParameter) -> Single<GitHubSearchResult>
}

final class GitHubSearchRepository: GitHubSearchRepositoryProtocol {
    func search(parameter: GitHubSearchParameter) -> Single<GitHubSearchResult> {
        return APIClientManager.client.request(GitHubAPIEndpoints.search(parameter: parameter))
    }
}
