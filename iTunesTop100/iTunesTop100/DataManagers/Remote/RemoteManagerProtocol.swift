//
//  RemoteManagerProtocol.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 10/4/21.
//

import Foundation

protocol RemoteDataManagerProtocol: class {
    func fetchSongList(completion: @escaping (Result<FeedResponse?, Error>) -> ())
    func fetchImage(imageUrl: String, size: String, completion: @escaping (Data) -> ())
}

