//
//  LandingViewController.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/17/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet private var tvShowButton: UIButton!
    @IBOutlet private var movieButton: UIButton!
    
    private let accessibilityKey = AccessibilityKey.LandingViewController.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = accessibilityKey.root
        
        navigationItem.title = "Trailer Teaser"
        
        tvShowButton.setTitle("TV show clips", for: .normal)
        tvShowButton.accessibilityIdentifier = accessibilityKey.tvShowButton
        
        movieButton.setTitle("Movie clips", for: .normal)
        movieButton.accessibilityIdentifier = accessibilityKey.movieButton
    }
    
    @IBAction private func tvShowButtonSelected(_ sender: Any) {
        navigateToShowList(showType: .tv)
    }
    
    @IBAction private func movieButtonSelected(_ sender: Any) {
        navigateToShowList(showType: .movie)
    }
    
    private func navigateToShowList(showType: ShowType) {
        let storyboard = navigationController?.storyboard
        let viewController = storyboard?.instantiateViewController(identifier: "\(ShowListViewController.self)")
        guard let showListViewController = viewController as? ShowListViewController else { return }
        
        showListViewController.showType = showType
        navigationController?.pushViewController(showListViewController, animated: true)
    }
}

