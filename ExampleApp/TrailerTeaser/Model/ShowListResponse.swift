//
//  ShowListResponse.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/19/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import Foundation

struct ShowListResponse: Decodable {
    let result: [Show]?
    let message: String?
}
