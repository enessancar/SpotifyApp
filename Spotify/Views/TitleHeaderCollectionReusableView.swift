//
//  TitleHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Enes Sancar on 9.09.2023.
//

import UIKit
import SnapKit

final class TitleHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleHeaderCollectionReusableView"
    
    //MARK: - Properties
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(frame.height)
        }
    }
    
    func configure(with title: String) {
        label.text = title
    }
}
