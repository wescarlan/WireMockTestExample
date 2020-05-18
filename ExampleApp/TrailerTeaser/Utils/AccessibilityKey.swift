//
//  AccessibilityKey.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/18/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

struct AccessibilityKey {
    
    struct LandingViewController {
        static let root = "LandingViewController"
        static let tvShowButton = "LandingViewController.tvShowButton"
        static let movieButton = "LandingViewController.movieButton"
    }
    
    struct ShowListViewController {
        static let root = "ShowListViewController"
        static let tableView = "ShowListViewController.tableView"
    }
    
    struct ShowTableViewCell {
        static let root = "ShowTableViewCell"
        static let nameLabel = "ShowTableViewCell.nameLabel"
        static let yearLabel = "ShowTableViewCell.yearLabel"
    }
    
    struct ShowDetailsViewController {
        static let root = "ShowDetailsViewController"
        static let imageView = "ShowDetailsViewController.imageView"
        static let titleLabel = "ShowDetailsViewController.titleLabel"
        static let categoryLabel = "ShowDetailsViewController.categoryLabel"
        static let dateLabel = "ShowDetailsViewController.dateLabel"
        static let openInSafariButton = "ShowDetailsViewController.openInSafariButton"
        static let descriptionLabel = "ShowDetailsViewController.descriptionLabel"
    }
}
