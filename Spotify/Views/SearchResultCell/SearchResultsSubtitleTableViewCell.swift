//
//  SearchResultsSubtitleTableViewCell.swift
//  Spotify
//
//  Created by Enes Sancar on 12.09.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchResultsSubtitleTableViewCell: UITableViewCell {
    static let identifier = "SearchResultsSubtitleTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(label, subtitleLabel, iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        subtitleLabel.text = nil
        iconImageView.image = nil
    }
    
    private func configureView() {
        let height = contentView.frame.height
        
        iconImageView.layer.cornerRadius = height / 2
        iconImageView.layer.masksToBounds = true
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(height)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(height / 2)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.height.equalTo(height / 2)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }
    }
    
    func configure(with viewModel: SearchResultsSubtitleTableViewCellViewModel) {
        label.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        iconImageView.kf.setImage(with: viewModel.imageURL)
    }
}
