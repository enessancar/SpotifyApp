//
//  AlbumTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Enes Sancar on 9.09.2023.
//

import UIKit
import SnapKit

final class AlbumTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumTrackCollectionViewCell"
    
    //MARK: - Properties
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
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubviews(trackNameLabel, artistNameLabel)
        contentView.clipsToBounds = true
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        artistNameLabel.text = nil
        trackNameLabel.text  = nil
    }
    
    private func configureView() {
        trackNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(contentView.frame.height / 2)
        }
        
        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(trackNameLabel.snp.bottom)
            make.leading.trailing.height.equalTo(trackNameLabel)
        }
    }
    
    func configure(with viewModel: AlbumCollectionViewCellViewModel) {
        artistNameLabel.text = viewModel.artistName
        trackNameLabel.text  = viewModel.name
    }
}
