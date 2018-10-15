//
//  MainTabBarController.swift
//  RxExample
//
//  Created by Naraki on 10/12/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - Properties

    let tabBarIcons: [UIImage?] = [R.image.iconGithub()]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        tabBar.tintColor = UIColor.darkGray

        viewControllers = [GitHubRepositoriesViewController.instantiate()]
        viewControllers?.enumerated().forEach { (index, viewController) in
            viewController.tabBarItem.image = tabBarIcons[index]
        }
        self.title = viewControllers?.first?.tabBarItem.title
    }

}

extension MainTabBarController: UITabBarControllerDelegate {

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.title = item.title
    }

}
