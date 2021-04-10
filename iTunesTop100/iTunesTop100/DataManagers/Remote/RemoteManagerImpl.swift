//
//  RemoteManagerImpl.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 10/4/21.
//

import Foundation


class RemoteDataManagerImpl: RemoteDataManagerProtocol{
    
    
    // MARK: - Class properties
    var networkService: NetworkService
    
    
    // MARK: - Lifecycle
    init(service: NetworkService){
        self.networkService = service
    }
    
    // MARK: - Protocol implementatios
    func fetchSongList(completion: @escaping (Result<FeedResponse?, Error>) -> ()) {
        let request = FeedResquest()
        self.networkService.fetchData(this: request, for: completion)
    }
}

