//
//  LibraryToggleView.swift
//  Spotify
//
//  Created by Enes Sancar on 14.09.2023.
//

//
//  LibraryToggleView.swift
//  Spotify
//
//  Created by Afraz Siddiqui on 2/21/21.
//

import UIKit
import SnapKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}

class LibraryToggleView: UIView {

    enum State {
        case playlist
        case album
    }

    var state: State = .playlist

    weak var delegate: LibraryToggleViewDelegate?

    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        return button
    }()

    private let albumsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Albums", for: .normal)
        return button
    }()

    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(playlistButton)
        addSubview(albumsButton)
        addSubview(indicatorView)
        
        playlistButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
        albumsButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
        
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc private func didTapPlaylists() {
        state = .playlist
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapPlaylists(self)
    }

    @objc private func didTapAlbums() {
        state = .album
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapAlbums(self)
    }

    private func configureView() {
        playlistButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        albumsButton.snp.makeConstraints { make in
            make.leading.equalTo(playlistButton.snp.trailing)
            make.width.height.top.equalTo(playlistButton)
        }
        layoutIndicator()
    }
    
    func layoutIndicator() {
        switch state {
        case .playlist:
            indicatorView.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.width.equalTo(90)
                make.height.equalTo(3)
                make.top.equalTo(playlistButton.snp.bottom)
            }
            
        case .album:
            indicatorView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(100)
                make.top.equalTo(albumsButton.snp.bottom)
                make.width.equalTo(90)
                make.height.equalTo(3)
            }
        }
    }

    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
}
