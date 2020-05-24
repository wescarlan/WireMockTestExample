//
//  RapidApiError.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/24/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

enum RapidApiError: Error {
    case invalidUrl(configuration: RapidApiWebCalls.Configuration)
    case invalidResponse
    case custom(_ message: String?)
    
    var localizedDescription: String {
        switch self {
        case .invalidUrl(let configuration):
            return "Invalid URL with configuration: \(configuration)"
        case .invalidResponse:
            return "Invalid response returned from API"
        case .custom(let message):
            return message ?? "Unknown error"
        }
    }
}
