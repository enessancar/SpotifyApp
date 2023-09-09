//
//  Album.swift
//  Spotify
//
//  Created by Enes Sancar on 7.09.2023.
//

import Foundation

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
