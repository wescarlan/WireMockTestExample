//
//  Show.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/18/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import Foundation

struct Show: Codable {
    let id: Int
    let type: ShowType?
    let title: String
    let date: Date
    let description: String?
    let category: String?
    let thumbnail: URL?
    let siteUrl: URL?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case type = "site_section"
        case title
        case description
        case category = "type"
        case date
        case thumbnail
        case siteUrl = "site_url"
    }
}

enum ShowType: String, Codable {
    case tv = "Show"
    case movie = "Movie"
}
