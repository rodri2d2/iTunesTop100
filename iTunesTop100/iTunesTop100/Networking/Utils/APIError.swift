//
//  APIError.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 9/4/21.
//

import Foundation

struct APIError: Codable {
    let action: String?
    let errors: [String]?
}
