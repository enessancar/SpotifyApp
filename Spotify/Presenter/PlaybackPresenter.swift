//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Enes Sancar on 13.09.2023.
//

import UIKit

final class PlaybackPresenter {
    
    static func startPlayback(
        from viewController: UIViewController,
        track: AudioTrack
    ) {
        let vc = PlayerVC()
        viewController.present(vc, animated: true)
    }
}
