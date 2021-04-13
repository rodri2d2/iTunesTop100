//
//  DataManager.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 10/4/21.
//

import Foundation


class DataManager{
    
    // MARK: - Class properties
    let remoteManager: RemoteDataManagerImpl
    
    // MARK: - Lifecycle
    init(manager: RemoteDataManagerImpl) {
        self.remoteManager = manager
    }
}









// MARK: - Extesions to simplefy the readability of each data manager protocols
extension DataManager: SongListDataManager{
    func fetchSongList(completion: @escaping (Result<FeedResponse?, Error>) -> ()) {
        remoteManager.fetchSongList(completion: completion)
    }
}

extension DataManager: ImageService {    
    func fetchImage(imageUrl: String, size: String, completion: @escaping (Data) -> ()) {
        remoteManager.fetchImage(imageUrl: imageUrl, size: size, completion: completion)
    }
}
