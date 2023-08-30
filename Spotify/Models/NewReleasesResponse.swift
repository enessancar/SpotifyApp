//
//  NewReleasesResponse.swift
//  Spotify
//
//  Created by Enes Sancar on 30.08.2023.
//

import Foundation

struct NewReleasesResponse: Decodable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Decodable {
    let items: [Album]
}

struct Album: Decodable {
    let album_type: String
    let available_markets: [String]
    let id: String
    var images: [APIImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
}
