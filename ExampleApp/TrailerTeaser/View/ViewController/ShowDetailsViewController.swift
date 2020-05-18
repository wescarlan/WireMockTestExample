//
//  ShowDetailsViewController.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/23/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import SafariServices
import UIKit

class ShowDetailsViewController: UIViewController {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var categoryLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var openInSafariButton: UIButton!
    @IBOutlet private var openInSafariButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet private var descriptionLabel: UILabel!
    
    private let accessibilityKey = AccessibilityKey.ShowDetailsViewController.self
    
    var show: Show!
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = accessibilityKey.root
        
        navigationItem.title = "Details"
        
        imageView.load(url: show.thumbnail)
        imageView.accessibilityIdentifier = accessibilityKey.imageView
        
        titleLabel.text = show.title
        titleLabel.accessibilityIdentifier = accessibilityKey.titleLabel
        
        categoryLabel.text = show.category ?? "Video"
        categoryLabel.accessibilityIdentifier = accessibilityKey.categoryLabel
        
        dateLabel.text = dateFormatter.string(from: show.date)
        dateLabel.accessibilityIdentifier = accessibilityKey.dateLabel
        
        if show.siteUrl != nil {
            openInSafariButton.setTitle("Open in Safari", for: .normal)
        } else {
            openInSafariButton.isHidden = true
            openInSafariButtonTopConstraint.constant = 0
        }
        openInSafariButton.accessibilityIdentifier = accessibilityKey.openInSafariButton
        
        descriptionLabel.text = show.description?.htmlToString ?? "No description available"
        descriptionLabel.accessibilityIdentifier = accessibilityKey.descriptionLabel
    }
    
    @IBAction func didSelectOpenInSafari(_ sender: Any) {
        guard let url = show.siteUrl else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .popover
        navigationController?.present(safariViewController, animated: true, completion: nil)
    }
}
