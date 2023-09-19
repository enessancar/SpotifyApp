//
//  SearchResultDefaultTableViewCell.swift
//  Spotify
//
//  Created by Enes Sancar on 12.09.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchResultDefaultTableViewCell: UITableViewCell {
    static let identifier = "SearchResultDefaultTableViewCell"
    
    //MARK: - Properties
    private let label: UILabel = {
        let label = UILabel()
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
        contentView.addSubviews(label, iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
        configureView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        iconImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureView() {
        let height = contentView.frame.height - 5
        
        iconImageView.layer.cornerRadius = height / 2
        iconImageView.layer.masksToBounds = true
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(height)
            make.centerY.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with viewModel: SearchResultDefaultTableViewCellViewModel) {
        label.text = viewModel.title
        iconImageView.kf.setImage(with: viewModel.imageURL)
    }
}
