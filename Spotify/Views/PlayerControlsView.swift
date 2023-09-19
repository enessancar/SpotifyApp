//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Enes Sancar on 18.09.2023.
//

import UIKit
import SnapKit

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapPlayForwardButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapPlayBackwardButton(_ playerControlsView: PlayerControlsView)
}

struct PlayerControlsViewViewModel {
    let title: String?
    let subtitle: String?
}

final class PlayerControlsView: UIView {
    
    weak var delegate: PlayerControlsViewDelegate?
    
    //MARK: - Properties
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubviews(nameLabel, subtitleLabel)
        addSubview(volumeSlider)
        addSubviews(backButton, nextButton, backButton)
        
        clipsToBounds = true
        configureView()
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
    }
    
    @objc private func didTapBack() {
        delegate?.playerControlsViewDidTapPlayBackwardButton(self)
    }
    
    @objc private func didTapNext() {
        delegate?.playerControlsViewDidTapPlayForwardButton(self)
    }
    
    @objc private func didTapPlayPause() {
        delegate?.playerControlsViewDidTapPlayPauseButton(self)
    }
    
    private func configureView() {
        nameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        volumeSlider.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            make.width.equalTo(frame.width - 20)
            make.height.equalTo(44)
        }
        
        let buttonSize: CGFloat = 60
        playPauseButton.snp.makeConstraints { make in
            make.top.equalTo(volumeSlider.snp.bottom).offset(30)
            make.width.height.equalTo(buttonSize)
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.width.height.equalTo(playPauseButton)
            make.trailing.equalTo(playPauseButton.snp.leading).offset(-30)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.width.height.equalTo(playPauseButton)
            make.leading.equalTo(playPauseButton.snp.trailing).offset(30)
        }
    }
    
    func configure(with viewModel: PlayerControlsViewViewModel) {
        nameLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
