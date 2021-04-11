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
    
    
    // MARK: - Outlets
    private lazy var collectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //
        view.delegate   = self
        view.dataSource = self
        view.register(WaterRelatedCell.self, forCellWithReuseIdentifier: "WaterRelatedCell")
        //
        view.translatesAutoresizingMaskIntoConstraints = false
        //
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        return view
    }()
    
    
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
        self.songListViewModel.loadData()
        setupOutlets()
    }
    
    
    // MARK: - Setup Outlets
    private func setupOutlets(){
        self.view.backgroundColor = .white
        setupCollectionView()
        setupContainerView()
        setupTableView()
    }
    private func setupNavigationBar(){}
    private func setupCollectionView(){
        self.view.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        
        //Constraints
        collectionView.backgroundColor = .red
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive           = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive   = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        //
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setupContainerView(){
        self.view.addSubview(containerView)
        
        //Constraints
        containerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive   = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupTableView(){
        
        self.containerView.addSubview(tableView)
        tableView.pin(to: containerView)
    }
    
}



// MARK: - Extensions for CollectionView
//DataSouce
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaterRelatedCell", for: indexPath) as! WaterRelatedCell
        cell.backgroundColor = .blue
        return cell
        
    }
}

//Delegate
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let squareSize = CGFloat(collectionView.frame.width/2.5)
        let size = CGSize(width: squareSize, height: squareSize)
        return size
        
    }
    
}




// MARK: - Extensions for TableView

//DataSource
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
}

//Delegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
