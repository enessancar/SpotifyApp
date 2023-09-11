//
//  AllCategoriesResponse.swift
//  Spotify
//
//  Created by Enes Sancar on 10.09.2023.
//

import Foundation

struct AllCategoriesResponse: Decodable {
    let categories: Categories
}

struct Categories: Decodable {
    let items: [Category]
}

struct Category: Decodable {
    let id: String
    let name: String
    let icons: [APIImage]
}
