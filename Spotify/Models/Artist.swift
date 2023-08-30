//
//  Artist.swift
//  Spotify
//
//  Created by Enes Sancar on 27.08.2023.
//

import Foundation

struct Artist: Decodable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
