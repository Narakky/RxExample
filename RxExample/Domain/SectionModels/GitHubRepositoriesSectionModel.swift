//
//  GitHubRepositoriesSectionModel.swift
//  RxExample
//
//  Created by Naraki on 10/15/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import UIKit
import RxDataSources

typealias GitHubRepositoriesSectionModel = SectionModel<GitHubRepositoriesSection, GitHubSearchItem>

enum GitHubRepositoriesSection {
    case item
    case common
}
