//
//  iTunesTop100Tests.swift
//  iTunesTop100Tests
//
//  Created by Rodrigo  Candido on 10/4/21.
//

import XCTest


// MARK: - TESTABLE modules
@testable import iTunesTop100


class iTunesTop100RequestTests: XCTestCase {
    
    var networkService: NetworkService!
    
    override func setUp() {
        networkService = NetworkService()
    }
    
    func test_FailToRetreiveCorrectData(){
        
        var request = FeedResquest()
        let url = URL(string: "https://www.google.com")
        request.baseURL = url!
        
        networkService.fetchData(this: request) { (result) in
            switch result{
            case .success(_):
                XCTFail()
            case .failure(_):
                XCTAssert(true)
            }
        }
    }
    
    func test_DecodeListResult(){
        let request = FeedResquest()
        networkService.fetchData(this: request) { (result) in
            switch result {
            case .success(_):
                XCTAssert(true)
            case .failure(_):
                XCTFail("Fail to decode from json to ListResult")
            }
        }
    }
    
}
