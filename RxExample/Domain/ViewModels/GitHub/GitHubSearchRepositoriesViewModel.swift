//
//  GitHubSearchRepositoriesViewModel.swift
//  RxExample
//
//  Created by Naraki on 10/12/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

final class GitHubSearchRepositoriesViewModel: ViewModelProtocol {
    struct Input {

    }
    struct Output {
        var items: Observable<[GitHubRepositoriesSectionModel]>
    }

    // MARK: - Properties

    private let useCase: GitHubSearchUseCaseProtocol
    private let items = BehaviorRelay<[GitHubRepositoriesSectionModel]>(value: [])

    // MARK: - Initializer

    init(useCase: GitHubSearchUseCaseProtocol = GitHubSearchUseCase(gitHubSearchRepository: GitHubSearchRepository())) {
        self.useCase = useCase
    }

    // MARK: - Transform Input To Output

    func transform(input: GitHubSearchRepositoriesViewModel.Input) -> GitHubSearchRepositoriesViewModel.Output {
        return Output(items: items.asObservable())
    }

    // MARK: - Internal Functions

    func fetchRepositories(parameter: GitHubSearchParameter) -> Observable<Void> {
        return useCase.invoke(parameter: parameter)
            .flatMap { [weak self] (result) -> Single<Void> in
                let sectionModels: [GitHubRepositoriesSectionModel] = [.repositoryItemSection(items: result.items),
                                                                       .loadingSection(items: [NSObject()])]
                self?.items.accept(sectionModels)
                return Single.just(())
            }.asObservable()
    }

}
