//
//  FeedResquest.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 9/4/21.
//

import Foundation


struct FeedResquest: APIRequest {
    
    var httpMethod: HTTPMethod = .get
    typealias Response = FeedResponse
}
