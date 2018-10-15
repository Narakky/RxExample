//
//  GitHubRepositoriesSectionModel.swift
//  RxExample
//
//  Created by Naraki on 10/15/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import UIKit
import RxDataSources

enum GitHubRepositoriesSection {
    case item
}

struct GitHubRepositoriesSectionModel: SectionModelType {
    typealias Item = GitHubSearchItem
    let section: GitHubRepositoriesSection
    var items: [GitHubSearchItem]

    init(section: GitHubRepositoriesSection, items: [Item]) {
        self.section = section
        self.items = items
    }

    init(original: GitHubRepositoriesSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
