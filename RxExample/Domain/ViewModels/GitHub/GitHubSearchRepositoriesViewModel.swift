//
//  GitHubSearchRepositoriesViewModel.swift
//  RxExample
//
//  Created by Naraki on 10/12/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import RxSwift

final class GitHubSearchRepositoriesViewModel: ViewModelProtocol {
    struct Input {

    }
    struct Output {

    }

    private let useCase: GitHubSearchUseCaseProtocol

    // MARK: - Initializer

    init(useCase: GitHubSearchUseCaseProtocol = GitHubSearchUseCase(gitHubSearchRepository: GitHubSearchRepository())) {
        self.useCase = useCase
    }

    func transform(input: GitHubSearchRepositoriesViewModel.Input) -> GitHubSearchRepositoriesViewModel.Output {
        return Output()
    }
}
