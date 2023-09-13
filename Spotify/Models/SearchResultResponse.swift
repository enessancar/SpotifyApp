//
//  SearchResultResponse.swift
//  Spotify
//
//  Created by Enes Sancar on 11.09.2023.
//

import Foundation

struct SearchResultsResponse: Decodable {
    let albums: SearchAlbumResponse
    let artists: SearchArtistsResponse
    let playlists: SearchPlaylistsResponse
    let tracks: SearchTracksResponse
}

struct SearchAlbumResponse: Decodable {
    let items: [Album]
}

struct SearchArtistsResponse: Decodable {
    let items: [Artist]
}

struct SearchPlaylistsResponse: Decodable {
    let items: [Playlist]
}

struct SearchTracksResponse: Decodable {
    let items: [AudioTrack]
}
