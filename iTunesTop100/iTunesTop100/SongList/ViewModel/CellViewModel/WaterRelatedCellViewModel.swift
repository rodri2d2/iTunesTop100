//
//  WaterRelatedCellViewModel.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 12/4/21.
//

import Foundation

class WaterRelatedCellViewModel: CellViewModel {
    
    
    // MARK: - Class propeties
    let songList:       ListResult
    let artistNameText: String
    let songNameText:   String
    var albumImage:     Data?
    var delegate:       WaterRelatedCellViewModelDelegate?
    
    // MARK: - Protocol implemantacions
    var type: CellType = .hasWaterRelationCell
    
    // MARK: - Lifecycle
    init(_ song: ListResult, dataManager: SongListDataManager) {
        
        self.songList       = song
        self.artistNameText = songList.artistName
        self.songNameText   = songList.songName
        
        dataManager.fetchImage(imageUrl: self.songList.artWorkURL, size: "200") { (data) in
            DispatchQueue.main.async {
                self.albumImage = data
                self.delegate?.didFinishFetchImage()
            }
        }
        

    }
    
    
}
