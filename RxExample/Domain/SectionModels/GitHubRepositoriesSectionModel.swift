//
//  GitHubRepositoriesSectionModel.swift
//  RxExample
//
//  Created by Naraki on 10/15/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import UIKit
import RxDataSources

enum GitHubRepositoriesSectionModel {
    case repositoryItemSection(items: [GitHubSearchItem])
    case loadingSection(items: [NSObject])
}

extension GitHubRepositoriesSectionModel: SectionModelType {
    typealias Item = Any

    var items: [Item] {
        switch self {
        case .repositoryItemSection(items: let items):
            return items
        case .loadingSection(items: let items):
            return items
        }
    }

    init(original: GitHubRepositoriesSectionModel, items: [Any]) {
        self = original
    }
}
