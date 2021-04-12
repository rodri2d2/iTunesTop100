//
//  SongListDataManager.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 10/4/21.
//

import Foundation


protocol SongListDataManager: class, ImageService {
    func fetchSongList(completion: @escaping (Result<FeedResponse?, Error>) -> ())
}
