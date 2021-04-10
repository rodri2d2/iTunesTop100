//
//  iTunesTop100DataManagerTests.swift
//  iTunesTop100Tests
//
//  Created by Rodrigo  Candido on 10/4/21.
//

import XCTest

// MARK: - TESTABLE modules
@testable import iTunesTop100

class iTunesTop100DataManagerTests: XCTestCase {

    var remoteManager:  RemoteDataManagerImpl!
    var networkService: NetworkService!
    var dataManager:    DataManager!
    
    override func setUp() {
        networkService = NetworkService()
        remoteManager = RemoteDataManagerImpl(service: networkService)
        dataManager = DataManager(manager: remoteManager)
    }
    
    
    func test_DataManagerResponseOnCompletion(){
        
        let songListDataManager = dataManager
        songListDataManager?.fetchSongList(completion: { (result) in
            switch result{
            case .success(_):
                XCTAssert(true)
            case .failure(_):
                XCTFail("Not correct result")
            }
        })
    }
    
    
    func test_DataManagerResponseOnCompletion_and_HasACountableResponse(){
        let songListDataManager = dataManager
        songListDataManager?.fetchSongList(completion: { (result) in
            
            switch result{
            case .success(let response):
                XCTAssertTrue((response?.feed?.songList.count)! > 0)
            case .failure(_):
                XCTFail("Not correct result")
            }
        })
    }

}
