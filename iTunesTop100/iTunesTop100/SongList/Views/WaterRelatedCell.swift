//
//  WaterRelatedCells.swift
//  iTunesTop100
//
//  Created by Rodrigo  Candido on 11/4/21.
//

import UIKit

class WaterRelatedCell: UICollectionViewCell {
    
    // MARK: - Class properties
    var viewModel: WaterRelatedCellViewModel?{
        didSet{
            
            guard let viewModel = viewModel else { return  }
            self.viewModel?.delegate = self
            self.artistLabel.text = viewModel.artistNameText
            self.songLabel.text = viewModel.songNameText
            //
            if let image = viewModel.albumImage{
                self.albumImageView.image = UIImage(data: image)
                
            }
        }
    }
    
    // MARK: - Outlets
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var albumImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private lazy var artistLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.numberOfLines = 1
        view.textAlignment = .left
        view.lineBreakMode = .byTruncatingTail
        view.adjustsFontSizeToFitWidth = false
        return view
    }()
    
    private lazy var songLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = .secondaryLabel
        view.numberOfLines = 1
        view.textAlignment = .left
        view.lineBreakMode = .byTruncatingTail
        view.adjustsFontSizeToFitWidth = false
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupOutlets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.albumImageView.image = nil
        self.artistLabel.text     = nil
        self.songLabel.text       = nil
    }
}

















// MARK: - Extension for Outlet setup
extension WaterRelatedCell{
    private func setupOutlets(){
        setupContainerView()
        setupAlbumImageView()
        setupArtistLabel()
        setupSongLabel()
    }
    
    private func setupContainerView(){
        self.contentView.addSubview(containerView)
        self.containerView.pin(to: self.contentView)
        self.containerView.backgroundColor = .appBackground
    }
    
    private func setupAlbumImageView(){
        
        containerView.addSubview(albumImageView)
        self.albumImageView.constraintFourPoints(on: containerView, withTop: 0, bottom: 50, leading: 0, trailing: 0)
        
        //Design
        albumImageView.layer.masksToBounds = true
        albumImageView.layer.cornerRadius = CGFloat(16)
        albumImageView.layer.shadowRadius = CGFloat(4)
        albumImageView.layer.shadowColor = UIColor.gray.cgColor
        albumImageView.layer.shadowOffset = CGSize(width: 2, height: 6)
        albumImageView.layer.shadowOpacity = 0.3
    }
    
    private func setupArtistLabel(){
        self.containerView.addSubview(artistLabel)
        self.artistLabel.constraintFourPoints(on: containerView, withTop: 108, bottom: 16, leading: 2, trailing: 2)
    }
    
    private func setupSongLabel(){
        self.containerView.addSubview(songLabel)
        self.songLabel.constraintFourPoints(on: containerView, withTop: 132, bottom: 8, leading: 2, trailing: 2)
    }
}
















// MARK: - Extension for SongListCellViewModelDelegate
extension WaterRelatedCell: WaterRelatedCellViewModelDelegate{
    func didFinishFetchImage() {
        if let image = viewModel?.albumImage{
            albumImageView.image = UIImage(data: image)
        }
    }
}
