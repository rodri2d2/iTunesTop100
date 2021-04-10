//
//  NetworkService.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 9/4/21.
//

import Foundation

class NetworkService: NSObject{
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    
    func fetchData<T: APIRequest>(this resquest: T, for completion: @escaping(Result<T.Response?, Error>) -> Void){
        
        let request = resquest.baseRequest()
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            //Error
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            
            
            //Data
            if let data = data{
                
                do {
                    let model = try JSONDecoder().decode(T.Response.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                } catch {
                    if data.isEmpty{
                        DispatchQueue.main.async {
                            completion(.success(nil))
                        }
                    }
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }
    
}
