//
//  SongListViewModel.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 10/4/21.
//

import Foundation


class SongListViewModel{
    
    
    // MARK: - Class properties
    let dataManager: SongListDataManager
    var hasWaterRelatedSong = false
    
    // MARK: - Lifecycle
    init(dataManager: SongListDataManager) {
        self.dataManager = dataManager
    }
    
}
