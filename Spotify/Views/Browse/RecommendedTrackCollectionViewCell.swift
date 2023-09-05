//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Enes Sancar on 31.08.2023.
//

import UIKit
import Kingfisher
import SnapKit

final class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    //MARK: - Properties
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        contentView.backgroundColor  = .secondarySystemBackground
        
        contentView.addSubviews(albumCoverImageView, trackNameLabel, artistNameLabel)
        contentView.clipsToBounds = true
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumCoverImageView.image = nil
        trackNameLabel.text = nil
        artistNameLabel.text = nil
    }
    
    private func configureView() {
        albumCoverImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-4)
            make.width.equalTo(64)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(albumCoverImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        artistNameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalTo(albumCoverImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    func configure(with viewModel: RecommendedTrackCellViewModel) {
        albumCoverImageView.kf.setImage(with: viewModel.artworkURL)
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
    }
}
