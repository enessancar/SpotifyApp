//
//  LibraryPlaylistResponse.swift
//  Spotify
//
//  Created by Enes Sancar on 14.09.2023.
//

import Foundation

struct LibraryPlaylistResponse: Decodable {
    let items: [Playlist]
}
