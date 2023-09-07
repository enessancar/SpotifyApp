//
//  AlbumDetailsResponse.swift
//  Spotify
//
//  Created by Enes Sancar on 7.09.2023.
//

import Foundation

struct AlbumDetailsResponse: Decodable {
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let label: String
    let name: String
    let tracks: TrackResponse
}

struct TrackResponse: Decodable {
    let items: [AudioTrack]
}
