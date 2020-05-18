//
//  UIKit+Utils.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/23/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL?, placeholder: UIImage? = nil) {
        if let placeholder = placeholder {
            image = placeholder
        }
        
        guard let url = url else { return }
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { self?.image = image }
        }
    }
}
