//
//  ShowListResponse.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/19/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import Foundation

struct ShowListResponse: Codable {
    var result: [Show]?
    var message: String?
    var error: Bool?
    
    init(result: [Show]?) {
        self.result = result
        self.message = nil
        self.error = false
    }
}
