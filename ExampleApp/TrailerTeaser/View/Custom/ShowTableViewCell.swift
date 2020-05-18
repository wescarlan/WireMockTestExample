//
//  ShowTableViewCell.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/18/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    private let accessibilityKey = AccessibilityKey.ShowTableViewCell.self
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return formatter
    }()
    
    var show: Show! {
        didSet { updateShow() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.accessibilityIdentifier = accessibilityKey.root
        
        nameLabel.accessibilityIdentifier = accessibilityKey.nameLabel
        dateLabel.accessibilityIdentifier = accessibilityKey.yearLabel
        
        updateShow()
    }
    
    private func updateShow() {
        guard let show = show else { return }
        
        nameLabel?.text = "\(show.title)"
        dateLabel?.text = "(\(dateFormatter.string(from: show.date)))"
    }
}
