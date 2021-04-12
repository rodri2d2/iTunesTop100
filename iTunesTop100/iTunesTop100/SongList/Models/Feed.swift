//
//  Feed.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 9/4/21.
//

import Foundation


struct Feed: Codable {
    
    enum CodingKeys: String, CodingKey {
        case songList = "results"
    }
    
    let songList: [ListResult]
}
