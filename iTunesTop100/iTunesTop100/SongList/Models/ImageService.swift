//
//  ImageService.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 12/4/21.
//

import Foundation

protocol ImageService {
    func fetchImage(imageUrl: String, size: String, completion: @escaping (_ imageData: Data)-> ())
}
