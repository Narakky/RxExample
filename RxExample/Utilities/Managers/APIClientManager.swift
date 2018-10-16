//
//  APIClientManager.swift
//  RxExample
//
//  Created by Naraki on 10/11/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import Moya
import RxSwift
import RxMoya

protocol APITargetType: TargetType {
    associatedtype Parameter: Encodable
    associatedtype Response: Codable
}

class APIClientManager {
    static let client = APIClientManager()
    private let provider = MoyaProvider<MultiTarget>()

    func request<T>(_ request: T) -> Single<T.Response> where T: APITargetType {
        let target = MultiTarget(request)

        return provider.rx.request(target)
            .filterSuccessfulStatusAndRedirectCodes()
            .map { decodableData in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                return try decoder.decode(T.Response.self, from: decodableData.data)
        }
    }

    func requestRaw<T>(_ request: T) -> Single<Response> where T: APITargetType {
        let target = MultiTarget(request)
        return provider.rx.request(target)
            .filterSuccessfulStatusAndRedirectCodes()
    }
}
