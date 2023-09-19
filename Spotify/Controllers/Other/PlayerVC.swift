//
//  PlayerVC.swift
//  Spotify
//
//  Created by Enes Sancar on 27.08.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class PlayerVC: UIViewController {
    
    weak var dataSource: PlayerDataSource?
    
    //MARK: - Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue  
        return imageView
    }()
    
    private let controlView = PlayerControlsView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        view.addSubview(controlView)
        
        controlView.delegate = self
        
        configureBarButton()
        configureView()
        configure()
    }

    private func configureView() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.height)
            make.leading.equalToSuperview()
        }
        
        controlView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.width.equalTo(view.frame.width - 20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
        }
    }
    
    private func configure() {
        imageView.kf.setImage(with: dataSource?.imageURL)
        controlView.configure(with: .init(title: dataSource?.songName,
                                          subtitle: dataSource?.subtitle ))
    }
    
    private func configureBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
    
    @objc private func didTapAction() {
        //
    }
}

//MARK: - ControlsView Delegate
extension PlayerVC: PlayerControlsViewDelegate {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        <#code#>
    }
    
    func playerControlsViewDidTapPlayForwardButton(_ playerControlsView: PlayerControlsView) {
        <#code#>
    }
    
    func playerControlsViewDidTapPlayBackwardButton(_ playerControlsView: PlayerControlsView) {
        <#code#>
    }
}
