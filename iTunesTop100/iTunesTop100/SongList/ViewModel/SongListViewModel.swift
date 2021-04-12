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
    var viewModelDeledate: SongListViewModelDelegate?
    var hasWaterRelatedSong = false
    var songList:         [CellViewModel] = []
    var waterRelatedList: [CellViewModel] = []
    
    
    // MARK: - Lifecycle
    init(dataManager: SongListDataManager) {
        self.dataManager = dataManager
    }
    
    // MARK: - Class functionalities
    private func loadData(){
        self.dataManager.fetchSongList { (result) in
            switch result {
            
            case .success(let response):
                if let songList = response?.feed?.songList{
                    self.prepareList(songList: songList)
                    self.searchForWaterRelateSongs(songList: songList)
                    self.viewModelDeledate?.didFinishFetchSongList()
                }
            
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func prepareList(songList: [ListResult]){
        
        for song in songList {
            self.songList.append(SongListCellViewModel(song, dataManager: dataManager))
        }
        
    }
    
    private func searchForWaterRelateSongs(songList: [ListResult]){
        
        let words = WaterRelatedWords.words()
        let aguaSongs = words.map { (word) -> [ListResult] in
            songList.filter { (list) -> Bool in
                list.songName.lowercased().contains(word)
            }
        }
     
        let sanitizedArray = Array(aguaSongs.joined())
    
        self.waterRelatedList = sanitizedArray.map { (list) -> WaterRelatedCellViewModel in
            return WaterRelatedCellViewModel(list, dataManager: self.dataManager)
        }
    }
    
    func viewWasLoad(){
        loadData()
    }
    
}


// MARK: - Extension to repond tableView demands
extension SongListViewModel{
    
    func numberOfRows()->Int{
        return self.songList.count
    }
    
    func tableCellViewModel(indexPath: IndexPath) -> CellViewModel?{
        guard indexPath.row < songList.count else { return nil }
        return songList[indexPath.row]
    }
    
}


extension SongListViewModel{
    
    func numberOfItems() -> Int{
        return self.waterRelatedList.count > 0 ? waterRelatedList.count : 0
    }
    
    func collectionCellViewModel(indexPath: IndexPath) -> CellViewModel?{
        guard indexPath.row < waterRelatedList.count else { return nil }
        return waterRelatedList[indexPath.row]
    }
    
}
