//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Enes Sancar on 31.08.2023.
//

import UIKit
import SnapKit
import  Kingfisher

final class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    //MARK: - Properties
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(playlistCoverImageView, playlistNameLabel, creatorNameLabel)
        contentView.clipsToBounds = true
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text  = nil
        playlistCoverImageView.image = nil
    }
    
    private func configureView() {
        let imageSize: CGFloat = contentView.frame.height - 70
        
        playlistCoverImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.height.width.equalTo(imageSize)
            make.leading.equalTo((contentView.frame.width - imageSize) / 2)
        }
        
        playlistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(playlistCoverImageView.snp.bottom).offset(8)
            make.centerX.equalTo(playlistCoverImageView.snp.centerX)
        }
        
        creatorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(playlistNameLabel.snp.bottom).offset(8)
            make.centerX.equalTo(playlistCoverImageView.snp.centerX)
        }
    }
    
    func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        playlistCoverImageView.kf.setImage(with: viewModel.artworkURL)
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text  = viewModel.creatorName
    }
}
