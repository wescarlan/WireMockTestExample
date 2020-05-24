//
//  RapidApi.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/24/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

struct RapidApi {
    static let host = "box-office-buz1.p.rapidapi.com"
    
    struct HeaderField {
        static let rapidApiHost = "x-rapidapi-host"
        static let rapidApiKey = "x-rapidapi-key"
    }
    
    enum Path: String {
        case videos = "/videos"
    }
}
