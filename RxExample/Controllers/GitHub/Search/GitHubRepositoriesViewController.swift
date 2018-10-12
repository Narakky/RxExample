//
//  GitHubRepositoriesViewController.swift
//  RxExample
//
//  Created by Naraki on 10/12/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import UIKit

final class GitHubRepositoriesViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties

    private var viewModel: GitHubSearchRepositoriesViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Instantiation

    static func instantiate() -> GitHubRepositoriesViewController {
        let viewController = R.storyboard.gitHubRepository.gitHubRepositoriesViewController()!
        viewController.viewModel = GitHubSearchRepositoriesViewModel()
        return viewController
    }

}
