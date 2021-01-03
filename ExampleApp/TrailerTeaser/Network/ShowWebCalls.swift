//
//  ShowWebCalls.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/19/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import Foundation
import HttpUtils

final class ShowWebCalls: RapidApiWebCalls {
    
    private static let shared = ShowWebCalls()
    private static let urlSession = URLSession.shared
    
    static func initialize(configuration: Configuration) {
        shared.configuration = configuration
    }
    
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
    
    private static func url(configuration: Configuration, path: RapidApi.Path) -> URL? {
        var components = URLComponents()
        components.scheme = configuration.urlScheme.rawValue
        components.host = configuration.host
        components.port = configuration.port
        components.path = path.rawValue
        return components.url
    }
    
    private static func urlRequest(url: URL, method: HTTP.Method, configuration: Configuration) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue(configuration.apiHost, forHTTPHeaderField: RapidApi.HeaderField.rapidApiHost)
        request.setValue(configuration.apiKey, forHTTPHeaderField: RapidApi.HeaderField.rapidApiKey)
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
