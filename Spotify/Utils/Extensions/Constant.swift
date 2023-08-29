//
//  Constant.swift
//  Spotify
//
//  Created by Enes Sancar on 29.08.2023.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

struct SpotifyConstants {
    static let clientID = "e429dd57138e443cb79344e93bfcc8bf"
    static let secretClientID = "0c34fefb5ab04cdb8d6fc1f2dd92cb83"
    static let tokenAPIURL = "https://accounts.spotify.com/api/token"
    static let baseURL = "https://accounts.spotify.com/"
    static let redirectURI = "https://open.spotify.com/"
    static let urlEncoded = "application/x-www-form-urlencoded"
    static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
}
