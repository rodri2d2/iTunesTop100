//
//  SongListViewModel.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 11/4/21.
//

import Foundation


class SongListCellViewModel: CellViewModel{
    
    
    // MARK: - Class propeties
    let songList: ListResult
    let dataManager: SongListDataManager
    let artistNameText: String
    let songNameText: String
    
    // MARK: - Protocol implemantacions
    var type: CellType = .normalListCell
    
    // MARK: - Lifecycle
    init(_ song: ListResult, dataManager: SongListDataManager) {
        self.songList = song
        self.dataManager = dataManager
        
        self.artistNameText = songList.artistName
        self.songNameText   = songList.songName
        
    }
    
    
}
