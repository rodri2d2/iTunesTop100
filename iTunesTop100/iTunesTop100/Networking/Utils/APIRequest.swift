//
//  ApiRequest.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 9/4/21.
//

import Foundation


let apiURL = "https://rss.itunes.apple.com/api/v1/es/itunes-music/top-songs/all/100/explicit.json"

protocol APIRequest {
    
    associatedtype Response: Codable
    var httpMethod: HTTPMethod { get }
}


extension APIRequest{
    
    var baseURL: URL {
        
        get{
            guard let baseURL = URL(string: apiURL) else { fatalError("URL not valid") }
            return baseURL
        }
        
        set{  }

    }
    
    func baseRequest() -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.httpMethod = httpMethod.rawValue
        return request
    }
}
