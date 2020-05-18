//
//  ShowListViewController.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/18/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import UIKit

class ShowListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!
    
    private let showCellReuseId = "\(ShowTableViewCell.self)"
    private let accessibilityKey = AccessibilityKey.ShowListViewController.self
    
    var showType: ShowType!
    private var shows: [Show] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = accessibilityKey.root
        
        title = showType == .tv ? "TV Shows" : "Movies"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = accessibilityKey.tableView
        
        getShows(type: showType)
    }
    
    private func getShows(type: ShowType) {
        toggleLoadingView(true)
        ShowWebCalls.getLatestShows(type: type) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let shows):
                self.didGetShows(shows)
            case .failure(let error):
                self.didFailGettingShows(error)
            }
        }
    }
    
    private func toggleLoadingView(_ isVisible: Bool) {
        loadingIndicator.isHidden = !isVisible
        tableView.isHidden = isVisible
    }
    
    private func didGetShows(_ shows: [Show]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.toggleLoadingView(false)
            self.shows = shows
            self.tableView.reloadData()
        }
    }
    
    private func didFailGettingShows(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.toggleLoadingView(false)
            debugPrint(error)
        }
    }
}

// MARK: - UITableViewDataSource -
extension ShowListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: showCellReuseId, for: indexPath)
        if let showCell = cell as? ShowTableViewCell {
            showCell.show = shows[indexPath.row]
        }
        return cell
    }
}

// MARK: - UITableViewDelegate -
extension ShowListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = navigationController?.storyboard
        let viewController = storyboard?.instantiateViewController(identifier: "\(ShowDetailsViewController.self)")
        guard let showDetailsViewController = viewController as? ShowDetailsViewController else { return }
        
        showDetailsViewController.show = shows[indexPath.row]
        navigationController?.pushViewController(showDetailsViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
