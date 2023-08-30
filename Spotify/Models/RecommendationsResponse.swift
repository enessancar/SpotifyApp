//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by Enes Sancar on 30.08.2023.
//

import Foundation

struct RecommendationsResponse: Decodable {
    let tracks: [AudioTrack]
}
 
struct AudioTrack: Decodable {
    let album: Album
    let artists: [Artist]
    let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let id: String
    let name: String
    let popularity: Int
}
