//
//  GitHubSearchUseCase.swift
//  RxExample
//
//  Created by Naraki on 10/12/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import RxSwift

protocol GitHubSearchUseCaseProtocol {
    func invoke(parameter: GitHubSearchParameter) -> Single<GitHubSearchResult>
}

final class GitHubSearchUseCase: GitHubSearchUseCaseProtocol {

    private let repository: GitHubSearchRepositoryProtocol

    init(gitHubSearchRepository: GitHubSearchRepositoryProtocol) {
        self.repository = gitHubSearchRepository
    }

    func invoke(parameter: GitHubSearchParameter) -> Single<GitHubSearchResult> {
        return repository.search(parameter: parameter)
    }
}
