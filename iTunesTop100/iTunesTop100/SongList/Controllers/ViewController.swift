//
//  ViewController.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 8/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Class properties
    let songListViewModel: SongListViewModel
    
    // MARK: - Lifecycle
    init(viewModel: SongListViewModel) {
        self.songListViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

