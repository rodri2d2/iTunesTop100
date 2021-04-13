//
//  SongListViewModel.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 10/4/21.
//

import Foundation


class SongListViewModel{
    
    
    // MARK: - Class properties
    let dataManager:       SongListDataManager
    var viewModelDeledate: SongListViewModelDelegate?
    var lastLoad:          Date?
    var songList:          [ListResult]?
    var allSongsList:      [CellViewModel] = []
    var waterRelatedList:  [CellViewModel] = []
    
    
    // MARK: - Lifecycle
    init(dataManager: SongListDataManager) {
        self.dataManager = dataManager
    }
    
    // MARK: - Class functionalities
    private func loadDataFromServer(_ predicate:String = ""){
        self.dataManager.fetchSongList { (result) in
            switch result {
            
            case .success(let response):
                if let songList = response?.feed?.songList{
                    
                    if predicate.isEmpty{
                        self.prepareList(songList: songList)
                        self.searchForWaterRelateSongs(songList: songList)
                    }else{
                        self.searchForSong(songList: songList, predicate: predicate)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadLocalData(_ predicate: String = ""){
        
        if let songList = self.songList{
            if predicate.isEmpty{
                self.prepareList(songList: songList)
            }else{
                self.searchForSong(songList: songList, predicate: predicate)
            }
        }else{
            loadDataFromServer()
        }
    }
    
    
    private func prepareList(songList: [ListResult]){
        
        for song in songList {
            self.allSongsList.append(SongListCellViewModel(song, dataManager: dataManager))
        }
        self.viewModelDeledate?.didFinishFetchSongList()
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
    
    private func searchForSong(songList: [ListResult], predicate: String){
        self.allSongsList.removeAll()
        for song in songList{
            if song.songName.lowercased().contains(predicate.lowercased()){
                self.prepareList(songList: [song])
            }
        }
    }
    
    func viewWasLoad(){
        
        if lastLoad == nil {
            lastLoad = Date()
            loadDataFromServer()
        }else{
            let expirationTime: TimeInterval = 60 * 10
            guard let lastLoad = self.lastLoad else {  return }
            if Date().timeIntervalSince(lastLoad) < expirationTime {
                loadLocalData()
            }
        }
    }

}


















// MARK: - Extension to respond tableView demands
extension SongListViewModel{
    
    func numberOfRows()->Int{
        return self.allSongsList.count
    }
    
    func tableCellViewModel(indexPath: IndexPath) -> CellViewModel?{
        guard indexPath.row < allSongsList.count else { return nil }
        return allSongsList[indexPath.row]
    }
}



















// MARK: - Extension to respond collectionView demands
extension SongListViewModel{
    
    func numberOfItems() -> Int{
        return self.waterRelatedList.count > 0 ? waterRelatedList.count : 0
    }
    
    func collectionCellViewModel(indexPath: IndexPath) -> CellViewModel?{
        guard indexPath.row < waterRelatedList.count else { return nil }
        return waterRelatedList[indexPath.row]
    }
}
















// MARK: - Extension for Search bar
extension SongListViewModel{
    func searchForThisText(predicate: String){
        loadDataFromServer(predicate)
    }
}
