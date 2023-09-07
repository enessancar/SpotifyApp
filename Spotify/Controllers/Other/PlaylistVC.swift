//
//  PlaylistVC.swift
//  Spotify
//
//  Created by Enes Sancar on 27.08.2023.
//

import UIKit

final class PlaylistVC: UIViewController {
    
    private let playlist: Playlist
    
    //MARK: - Init
    init(playlist: Playlist) {
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        APICaller.shared.getPlaylistDetails(for: playlist) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
                print("zort")
            }
        }
    }
}
