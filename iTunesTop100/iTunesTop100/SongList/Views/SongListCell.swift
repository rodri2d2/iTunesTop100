//
//  SongListCell.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 11/4/21.
//

import UIKit

class SongListCell: UITableViewCell {
    
    
    // MARK: - Class properties
    var viewModel: SongListCellViewModel?{
        didSet{
            guard let viewModel = viewModel else { return  }
            self.artistLabel.text = viewModel.artistNameText
            self.songLabel.text   = viewModel.songNameText
            self.viewModel?.delegate = self
            
        }
    }
    
    // MARK: - Outlets
    private lazy var artistLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.numberOfLines = 1
        view.textAlignment = .left
        view.lineBreakMode = .byTruncatingTail
        view.adjustsFontSizeToFitWidth = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var songLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textColor = .secondaryLabel
        view.numberOfLines = 1
        view.textAlignment = .left
        view.lineBreakMode = .byTruncatingTail
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var albumImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupOutlets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.artistLabel.text = nil
        self.songLabel.text   = nil
    }
}


















// MARK: - Extension for Outlet setup
extension SongListCell{
    private func setupOutlets(){
        self.backgroundColor = .appBackground
        setupContainerView()
        setupArtistLabel()
        setupSongLabel()
        setupAlbumImageView()
    }
    
    
    private func setupContainerView(){
        self.contentView.addSubview(containerView)
        
        //Constraints
        containerView.constraintFourPoints(on: self.contentView, withTop: 8, bottom: 8, leading: 8, trailing: 8)
        
        
        //Visual Desing
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = CGFloat(8)
        containerView.layer.masksToBounds = false
        containerView.layer.shadowRadius = CGFloat(4)
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 2, height: 4)
        containerView.layer.shadowOpacity = 0.3
        
    }
    
    private func setupArtistLabel(){
        self.containerView.addSubview(artistLabel)
        //Constraints
        self.artistLabel.minimumConstraint(on: self.containerView, withTop: 16, leading: 80, trailing: 16)
        
    }
    
    private func setupSongLabel(){
        self.containerView.addSubview(songLabel)
        //Constraints
        self.songLabel.minimumConstraint(on: containerView, withTop: 40, leading: 80, trailing: 16)
    }
    
    private func setupAlbumImageView(){
        self.containerView.addSubview(albumImageView)
        
        //Constraints
        self.albumImageView.constraintFourPoints(on: self.containerView, withTop: 16, bottom: 16, leading: 4, trailing: 300)
        
        //Design
        self.albumImageView.layer.masksToBounds = true
        albumImageView.layer.cornerRadius = CGFloat(12)
        
        
    }
    
}

















extension SongListCell: SongListCellViewModelDelegate{
    func didFinishFetchImage() {
        if let image = viewModel?.albumImage{
            albumImageView.image = UIImage(data: image)
        }
    }
}
