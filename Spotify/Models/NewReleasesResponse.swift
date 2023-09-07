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
