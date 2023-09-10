//
//  GenreCollectionViewCell.swift
//  Spotify
//
//  Created by Enes Sancar on 10.09.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class GenreCollectionViewCell: UICollectionViewCell {
    static let idenditifier = "GenreCollectionViewCell"
    
    //MARK: - Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let colors: [UIColor] = [
        .systemPink,
        .systemRed,
        .systemYellow,
        .systemBlue,
        .systemPurple,
        .systemOrange,
        .systemTeal,
        .darkGray,
        .systemGreen
    ]
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(label, imageView)
        configureView()
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
    }
    
    private func configureView() {
        let height = contentView.frame.height
        let width  = contentView.frame.width
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(width / 2)
            make.height.equalTo(height / 2)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    func configure(with viewModel: CategoryCollectionViewCellViewModel) {
        label.text = viewModel.title
        imageView.kf.setImage(with: viewModel.artworkURL)
        contentView.backgroundColor = colors.randomElement()
    }
}
