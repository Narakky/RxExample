//
//  GitHubRepositoryItemCell.swift
//  RxExample
//
//  Created by Naraki on 10/15/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import UIKit

final class GitHubRepositoryItemCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var repoImage: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var stars: UILabel!
    @IBOutlet private weak var author: UILabel!
    @IBOutlet private weak var updatedAt: UILabel!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
    }

    // MARK: - Configuration

    func configure(item: GitHubSearchItem) {
        title.text = item.name
        repoImage.setImage(url: item.owner.avatarUrl, placeholder: R.image.no_image())
        descriptionLabel.text = item.description
        stars.text = item.stargazersCount.decimalCommaString
        author.text = item.owner.login
        updatedAt.text = item.updatedAt.formattedDateString
    }

}
