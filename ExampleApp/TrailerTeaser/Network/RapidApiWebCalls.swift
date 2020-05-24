//
//  RapidApiWebCalls.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/24/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import Foundation

class RapidApiWebCalls {
    
    struct Configuration {
        var urlScheme: URLScheme
        var host: String
        var port: Int?
        var apiHost: String?
        var apiKey: String?
        
        static func rapidApi(_ apiKey: String? = nil) -> Configuration {
            return Configuration(
                urlScheme: .https,
                host: RapidApi.host,
                apiHost: RapidApi.host,
                apiKey: apiKey)
        }
        
        static func localhost(_ port: String? = nil) -> Configuration {
            let port = Int(port ?? "8080")
            return Configuration(urlScheme: .http, host: "localhost", port: port)
        }
    }
    
    var configuration: Configuration
    
    init() {
        configuration = Configuration(urlScheme: .http, host: "", apiKey: "")
    }
}
