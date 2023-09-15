//
//  LibraryVC.swift
//  Spotify
//
//  Created by Enes Sancar on 27.08.2023.
//

import UIKit
import SnapKit

final class LibraryVC: UIViewController {
    
    private let playlistVC = LibraryPlaylistVC()
    private let albumsVC   = LibraryAlbumsVC()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private let toggleView = LibraryToggleView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(toggleView)
        toggleView.delegate = self
        
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.contentSize = .init(width: view.frame.width + 2, height: scrollView.frame.height)
        scrollView.backgroundColor = .yellow
        
        configureView()
        addChildren()
    }
    
    private func configureView() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(55)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        toggleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.leading.equalToSuperview()
        }
    }
    
    private func addChildren() {
        addChild(playlistVC)
        scrollView.addSubview(playlistVC.view)
        
        playlistVC.view.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(scrollView)
        }
        playlistVC.didMove(toParent: self)
        
        addChild(albumsVC)
        scrollView.addSubview(albumsVC.view)
        
        albumsVC.view.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(scrollView)
        }
        albumsVC.didMove(toParent: self)
    }
}


extension LibraryVC: UIScrollViewDelegate {
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        
    }
}

extension LibraryVC: LibraryToggleViewDelegate {
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(.init(x: view.frame.width, y: 0), animated: true)
    }
    
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(.zero, animated: true)
    }
}
