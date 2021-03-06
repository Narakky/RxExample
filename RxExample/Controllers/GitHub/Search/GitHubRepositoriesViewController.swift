//
//  GitHubRepositoriesViewController.swift
//  RxExample
//
//  Created by Naraki on 10/12/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class GitHubRepositoriesViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties

    private var viewModel: GitHubSearchRepositoriesViewModel!
    private var dataSource: RxTableViewSectionedReloadDataSource<GitHubRepositoriesSectionModel>!
    private let disposeBag = DisposeBag()

    private let refreshControl = UIRefreshControl()
    private var cellHeights: [IndexPath: CGFloat] = [:]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initTableViewLayout()
        bindViewModel()
        fetchRepositories()
    }

    // MARK: - Instantiation

    static func instantiate() -> GitHubRepositoriesViewController {
        let viewController = R.storyboard.gitHubRepository.gitHubRepositoriesViewController()!
        viewController.viewModel = GitHubSearchRepositoriesViewModel()
        viewController.dataSource = RxTableViewSectionedReloadDataSource<GitHubRepositoriesSectionModel>(configureCell: { (dataSource, tableView, indexPath, _) -> UITableViewCell in
            let model = dataSource[indexPath.section]
            switch model {
            case .repositoryItemSection(items: let items):
                let item = items[indexPath.row]
                guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubRepositoryItemCell.name, for: indexPath) as? GitHubRepositoryItemCell else { return UITableViewCell() }
                cell.configure(item: item)
                return cell
            case .loadingSection(items: _):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.loadingCell.name, for: indexPath) as? LoadingCell else { return UITableViewCell() }
                return cell
            }
        })
        return viewController
    }

    // MARK: - Private Methods

    private func initTableViewLayout() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(R.nib.gitHubRepositoryItemCell(), forCellReuseIdentifier: R.nib.gitHubRepositoryItemCell.name)
        tableView.register(R.nib.loadingCell(), forCellReuseIdentifier: R.nib.loadingCell.name)
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        tableView.refreshControl = self.refreshControl
    }

    private func bindViewModel() {
        let refreshControlShouldRefresh = refreshControl.rx.controlEvent(.valueChanged)
            .filter { self.refreshControl.isRefreshing }
            .asSignal(onErrorJustReturn: ())
        let input = GitHubSearchRepositoriesViewModel.Input(shouldRefresh: refreshControlShouldRefresh)
        let output = viewModel.transform(input: input)

        output.items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        output.hasFinishedForRefreshing.emit(onNext: { [weak self] in
            self?.fetchRepositories()
        }).disposed(by: disposeBag)
    }

    private func fetchRepositories() {
        viewModel.fetchRepositories().subscribe(onNext: { [weak self] _ in

            }, onError: { error in
                print("ERROR: \(error.localizedDescription)")
        }, onCompleted: { [weak self] in
            self?.refreshControl.endRefreshing()
        }).disposed(by: disposeBag)
    }

}

// MARK: - UITableViewDelegate

extension GitHubRepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? 50
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.bounds.height

        if cell is LoadingCell && tableView.indexPathsForVisibleRows?.contains(indexPath) == true {
            fetchRepositories()
        }
    }
}
