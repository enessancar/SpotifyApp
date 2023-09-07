//
//  AlbumVC.swift
//  Spotify
//
//  Created by Enes Sancar on 7.09.2023.
//

import UIKit

final class AlbumVC: UIViewController {
    
    private let album: Album
    
    //MARK: - Init
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        APICaller.shared.getAlbumDetails(for: album) { result in
            switch result {
            case .success(let success):
                print(success.name)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
