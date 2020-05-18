//
//  Foundation+Utils.swift
//  TrailerTeaser
//
//  Created by Wesley on 5/19/20.
//  Copyright © 2020 Wesley Carlan. All rights reserved.
//

import Foundation

enum URLScheme: String {
    case http, https
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

extension String {
    var htmlToAttributedString: NSAttributedString {
        guard let data = data(using: .utf8) else { return NSAttributedString(string: self) }
        do {
            let documentType = NSAttributedString.DocumentType.html
            let characterEncoding = String.Encoding.utf8.rawValue
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: documentType, .characterEncoding: characterEncoding]
            return try NSAttributedString(data: data, options: options, documentAttributes: nil)
        } catch {
            return NSAttributedString(string: self)
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString.string
    }
}
