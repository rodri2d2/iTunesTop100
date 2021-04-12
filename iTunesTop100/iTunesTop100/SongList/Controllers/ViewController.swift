//
//  ViewController.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 8/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Class properties
    let viewModel: SongListViewModel
    
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
        view.showsHorizontalScrollIndicator = false
        //
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate   = self
        view.dataSource = self
        view.register(SongListCell.self, forCellReuseIdentifier: "TableCell")
        //
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    
    // MARK: - Lifecycle
    init(viewModel: SongListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        //
        self.viewModel.viewModelDeledate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.viewWasLoad()
        setupOutlets()
    }
    
    
}


















// MARK: - Extension for Outlet setup
extension ViewController{
    
    private func setupOutlets(){
        self.view.backgroundColor = .appBackground
        setupNavigationBar()
        setupCollectionView()
        setupContainerView()
        setupTableView()
    }
    private func setupNavigationBar(){
        self.title = "Songs..."
    }
    
    private func setupCollectionView(){
        
        self.view.addSubview(collectionView)
        collectionView.minimumSafetyConstraint(on: self.view, withTop: 16, leading: 16, trailing: 16)
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
        collectionView.backgroundColor = .appBackground
        
    }
    
    private func setupContainerView(){
        self.view.addSubview(containerView)
        
        containerView.backgroundColor = .appBackground
        
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
        return self.viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cellViewModel = self.viewModel.collectionCellViewModel(indexPath: indexPath) as? SongListCellViewModel{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaterRelatedCell", for: indexPath) as? WaterRelatedCell{
                cell.viewModel = cellViewModel
                return cell
            }
        }
        return UICollectionViewCell()
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
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cellViewModel = self.viewModel.tableCellViewModel(indexPath: indexPath)as? SongListCellViewModel{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? SongListCell{
                cell.viewModel = cellViewModel
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

//Delegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


















// MARK: - Extension for ViewModelDelegate
extension ViewController: SongListViewModelDelegate{
    func didFinishFetchSongList() {
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }
}
