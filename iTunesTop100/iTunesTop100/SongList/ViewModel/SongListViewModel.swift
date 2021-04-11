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
    var data: [ListResult] = []
    
    
    // MARK: - Lifecycle
    init(dataManager: SongListDataManager) {
        self.dataManager = dataManager
    }
    
    // MARK: - Class functionalities
    func loadData(){
        self.dataManager.fetchSongList { (result) in
            switch result {
            
            case .success(let response):
                if let songList = response?.feed?.songList{
                    self.searchForWaterRelateSongs(songList: songList)
                }
            
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func searchForWaterRelateSongs(songList: [ListResult]){
        
        let words = WaterRelatedWords.words()
        let aguaSongs = words.map { (word) -> [ListResult] in
            songList.filter { (list) -> Bool in
                list.songName.lowercased().contains(word)
            }
        }
        
        let aguaSongList = Array(aguaSongs.joined())
    }
}
