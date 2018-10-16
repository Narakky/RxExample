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
        var shouldRefresh: Signal<Void>
    }
    struct Output {
        var items: Observable<[GitHubRepositoriesSectionModel]>
        var hasFinishedForRefreshing: Signal<Void>
    }

    // MARK: - Properties

    private let useCase: GitHubSearchUseCaseProtocol
    private let items = BehaviorRelay<[GitHubRepositoriesSectionModel]>(value: [])
    private let isRequesting = BehaviorRelay<Bool>(value: false)
    private let hasFinishedForRefreshing = PublishRelay<Void>()
    private var currentPage = 0
    private let requestPerPage: Int = 10
    private var hasItems = true
    private var shouldRefresh = false
    private let disposeBag = DisposeBag()

    // MARK: - Initializer

    init(useCase: GitHubSearchUseCaseProtocol = GitHubSearchUseCase(gitHubSearchRepository: GitHubSearchRepository())) {
        self.useCase = useCase
    }

    // MARK: - Transform Input To Output

    func transform(input: GitHubSearchRepositoriesViewModel.Input) -> GitHubSearchRepositoriesViewModel.Output {
        input.shouldRefresh.emit(onNext: { [weak self] _ in
            self?.hasItems = true
            self?.shouldRefresh = true
            self?.currentPage = 0
            self?.hasFinishedForRefreshing.accept(())
        }).disposed(by: disposeBag)

        return Output(items: items.asObservable(),
                      hasFinishedForRefreshing: hasFinishedForRefreshing.asSignal())
    }

    // MARK: - Internal Functions

    func fetchRepositories() -> Observable<Void> {
        guard isRequesting.value == false, hasItems == true else { return Observable.just(()) }

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
                if result.items.isEmpty {
                    self.hasItems = false
                }

                var sectionModels: [GitHubRepositoriesSectionModel] = [.repositoryItemSection(items: result.items)]
                if !result.items.isEmpty {
                    sectionModels.append(.loadingSection(items: [NSObject()]))
                }
                var updatedSectionModels: [GitHubRepositoriesSectionModel] = []
                if !self.shouldRefresh {
                    updatedSectionModels += self.items.value.filter {
                        switch $0 {
                        case .repositoryItemSection(_):
                            return true
                        default:
                            return false
                        }
                    }
                }
                updatedSectionModels += sectionModels
                self.items.accept(updatedSectionModels)

                self.shouldRefresh = false

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
