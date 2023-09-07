//
//  PlaylistDetailsResponse.swift
//  Spotify
//
//  Created by Enes Sancar on 7.09.2023.
//

import Foundation

struct PlaylistDetailsResponse: Decodable {
    let description: String?
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlaylistTrackResponse
}

struct PlaylistTrackResponse: Decodable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Decodable {
    let track: AudioTrack
}
