//
//  GitHubSearchRepositorySpec.swift
//  RxExampleTests
//
//  Created by Naraki on 10/11/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import Quick
import Nimble
@testable import RxExample
import RxSwift

class GitHubSearchRepositorySpec: QuickSpec {

    override func spec() {
        describe("GitHubSearchAPI導通確認") {
            let repository: GitHubSearchRepositoryProtocol = GitHubSearchRepository()
            let disposeBag: DisposeBag = DisposeBag()

            context("パラメータ無し") {
                it("正常にレスポンスを取得できること") {
                    waitUntil(timeout: 3) { done in
                        repository.search(parameter: GitHubSearchParameter())
                            .subscribe(onSuccess: { result in
                                done()
                            }, onError: { error in
                                print("ERROR: \(error)")
                                fail()
                            }).disposed(by: disposeBag)
                    }
                }
            }
            context("パラメータ有り") {
                it("正常にレスポンスを取得できること") {
                    waitUntil(timeout: 3) { done in
                        repository.search(parameter: GitHubSearchParameter(q: GitHubSearchParameter.Query(language: ["Ruby"], topic: ["Rails"]),
                                                                           sort: .stars,
                                                                           order: .desc))
                            .subscribe(onSuccess: { result in
                                done()
                            }, onError: { error in
                                print("ERROR: \(error)")
                            }).disposed(by: disposeBag)
                    }
                }
            }
        }
    }

}
