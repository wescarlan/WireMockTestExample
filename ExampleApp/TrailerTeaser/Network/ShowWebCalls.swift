//
//  ShowWebCalls.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/19/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import Foundation

final class ShowWebCalls {
    
    struct Configuration {
        var urlScheme: URLScheme
        var host: String
        var apiKey: String
    }
    
    private enum Path: String {
        case videos = "/videos"
    }
    
    private struct HTTPHeaderField {
        static let rapidApiHost = "x-rapidapi-host"
        static let rapidApiKey = "x-rapidapi-key"
    }
    
    private static let shared = ShowWebCalls()
    private static let urlSession = URLSession.shared
    
    private var configuration: Configuration
    
    private init() {
        configuration = Configuration(urlScheme: .http, host: "", apiKey: "")
    }
    
    static func initialize(configuration: Configuration) {
        shared.configuration = configuration
    }
    
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
    
    private static func url(configuration: Configuration, path: Path) -> URL? {
        var components = URLComponents()
        components.scheme = configuration.urlScheme.rawValue
        components.host = configuration.host
        components.path = path.rawValue
        return components.url
    }
    
    private static func urlRequest(url: URL, method: HTTPMethod, configuration: Configuration) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue(configuration.host, forHTTPHeaderField: HTTPHeaderField.rapidApiHost)
        request.setValue(configuration.apiKey, forHTTPHeaderField: HTTPHeaderField.rapidApiKey)
        return request
    }
    
    static func getLatestShows(type: ShowType, _ completion: @escaping (Result<[Show], Error>) -> Void) {
        getLatestVideos { (result) in
            switch result {
            case .success(let shows):
                completion(.success(shows.filter { $0.type == type }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private static func getLatestVideos(_ completion: @escaping (Result<[Show], Error>) -> Void) {
        let configuration = shared.configuration
        guard let url = url(configuration: configuration, path: .videos) else {
            completion(.failure(RapidApiError.invalidUrl(configuration: configuration)))
            return
        }
        
        let request = urlRequest(url: url, method: .get, configuration: configuration)
        let task = urlSession.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(RapidApiError.invalidResponse))
                return
            }
            
            do {
                let response = try decoder.decode(ShowListResponse.self, from: data)
                if let result = response.result {
                    completion(.success(result))
                } else {
                    completion(.failure(RapidApiError.custom(response.message)))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum RapidApiError: Error {
    case invalidUrl(configuration: ShowWebCalls.Configuration)
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
