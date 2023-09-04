//
//  NewReleasesCollectionViewCell.swift
//  Spotify
//
//  Created by Enes Sancar on 31.08.2023.
//

import UIKit
import SnapKit

final class NewReleasesCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleasesCollectionViewCell"
    
    //MARK: - Properties
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let numberOfTracksLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        
        addSubviews(albumCoverImageView, albumNameLabel, artistNameLabel, numberOfTracksLabel)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumCoverImageView.image = nil
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        numberOfTracksLabel.text = nil
    }
    
    private func configureView() {
        albumCoverImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.width.equalTo(80)
        }
        
        albumNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumCoverImageView.snp.trailing).offset(8)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
        
        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(albumNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(albumCoverImageView.snp.trailing).offset(8)
            make.height.equalTo(20)
        }
        
        numberOfTracksLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumCoverImageView.snp.trailing).offset(8)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
    }
    
    func configure(with viewModels: NewReleasesCellViewModel) {
        albumCoverImageView.kf.setImage(with: viewModels.artworkURL)
        
        albumNameLabel.text = viewModels.name
        artistNameLabel.text = viewModels.artistName
        numberOfTracksLabel.text = "Tracks: \(viewModels.numberOfTracks)"
    }
}
