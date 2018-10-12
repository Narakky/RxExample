//
//  ViewModelProtocol.swift
//  RxExample
//
//  Created by Naraki on 10/12/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    associatedtype Dependency

    func transform(input: Input) -> Output
}
