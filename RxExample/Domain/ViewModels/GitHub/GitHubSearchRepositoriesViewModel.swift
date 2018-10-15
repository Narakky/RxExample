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
    private let isRequesting = BehaviorRelay<Bool>(value: false)
    private var currentPage = 0
    private let requestPerPage: Int = 10

    // MARK: - Initializer

    init(useCase: GitHubSearchUseCaseProtocol = GitHubSearchUseCase(gitHubSearchRepository: GitHubSearchRepository())) {
        self.useCase = useCase
    }

    // MARK: - Transform Input To Output

    func transform(input: GitHubSearchRepositoriesViewModel.Input) -> GitHubSearchRepositoriesViewModel.Output {
        return Output(items: items.asObservable())
    }

    // MARK: - Internal Functions

    func fetchRepositories() -> Observable<Void> {
        guard isRequesting.value == false else { return Observable.just(()) }

        isRequesting.accept(true)

        currentPage += 1
        let parameter = makeRequestParameter(page: currentPage)
        return useCase.invoke(parameter: parameter)
            .catchError { [weak self] error in
                self?.isRequesting.accept(false)
                self?.currentPage -= 1
                return Observable.empty().asSingle()
            }
            .flatMap { [weak self] (result) -> Single<Void> in
                guard let `self` = self else { return Single.just(()) }

                self.isRequesting.accept(false)

                let sectionModels: [GitHubRepositoriesSectionModel] = [.repositoryItemSection(items: result.items),
                                                                       .loadingSection(items: [NSObject()])]

                let updatedSectionModels = self.items.value.filter {
                    switch $0 {
                    case .repositoryItemSection(_):
                        return true
                    default:
                        return false
                    }
                    } + sectionModels
                self.items.accept(updatedSectionModels)
                return Single.just(())
            }.asObservable()
    }

    // MARK: - Private Methods

    private func makeRequestParameter(page: Int) -> GitHubSearchParameter {
        return GitHubSearchParameter(languages: ["Swift", "Kotlin"],
                                     topics: ["iOS", "Android"],
                                     page: page,
                                     perPage: requestPerPage,
                                     sort: .updated,
                                     order: .desc)
    }

}
