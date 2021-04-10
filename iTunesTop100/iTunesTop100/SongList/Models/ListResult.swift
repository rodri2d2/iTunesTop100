//
//  Result.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 9/4/21.
//

import Foundation


struct ListResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case artistId
        case artistName
        case songName   = "name"
        case albumName  = "collectionName"
        case artWorkURL = "artworkUrl100"
        
    }
    
    let id:             String
    let artistId:       String
    let artistName:     String
    let songName:       String
    let albumName:      String
    let artWorkURL:     String
}
