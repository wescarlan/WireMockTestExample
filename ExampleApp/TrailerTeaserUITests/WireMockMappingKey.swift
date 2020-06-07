//
//  WireMockMappingKey.swift
//  TrailerTeaserUITests
//
//  Created by Wesley on 6/6/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import Foundation
import WireMockTest

enum WireMockMappingKey: String {
    case getVideos = "75983f73-de09-37dc-9eb2-f20eb42d0a71"
}

// MARK: - WireMockApi + WireMockMappingKey -
extension WireMockApi {
    func getMapping<T: Codable>(_ key: WireMockMappingKey, responseType: T.Type) -> WireMockMapping<T>? {
        guard let uuid = UUID(uuidString: key.rawValue) else { return nil }
        return getMapping(uuid, responseType: responseType)
    }
    
    func deleteMapping(_ key: WireMockMappingKey) {
        guard let uuid = UUID(uuidString: key.rawValue) else { return }
        deleteMapping(uuid)
    }
}

// MARK: - WireMockMapping + WireMockMappingKey -
extension WireMockMapping {
    var mappingKey: WireMockMappingKey? {
        return WireMockMappingKey(rawValue: uuid.uuidString)
    }
}
