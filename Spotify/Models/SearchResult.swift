//
//  SearchResult.swift
//  Spotify
//
//  Created by Enes Sancar on 11.09.2023.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
