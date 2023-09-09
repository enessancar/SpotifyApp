//
//  PlaylistHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Enes Sancar on 8.09.2023.
//

import UIKit
import Kingfisher
import SnapKit

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func playlistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView)
}

final class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "PlaylistHeaderCollectionReusableView"
    
    weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
    
    //MARK: - Properties
    private let nameLabel = BodyLabel(textColor: .label, fontSize: 22, weight: .semibold)
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    private let ownerLabel = BodyLabel(textColor: .secondaryLabel, fontSize: 18, weight: .light)
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private let playAllButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        let image = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubviews(imageView, nameLabel, descriptionLabel, ownerLabel, playAllButton)
        playAllButton.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didTapPlay() {
        delegate?.playlistHeaderCollectionReusableViewDidTapPlayAll(self)
    }
    
    private func configureView() {
        let imageSize: CGFloat = frame.height / 1.8
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(imageSize)
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(imageView.snp.bottom)
            make.height.equalTo(44)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.trailing.height.leading.equalTo(nameLabel)
        }
        
        ownerLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom)
            make.trailing.height.leading.equalTo(nameLabel)
        }
        
        playAllButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.bottom.trailing.equalToSuperview().offset(-20)
        }
    }
    
    public func configure(with viewModel: PlaylistHeaderViewViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        ownerLabel.text = viewModel.ownerName
        imageView.kf.setImage(with: viewModel.artworkURL)
    }
}
