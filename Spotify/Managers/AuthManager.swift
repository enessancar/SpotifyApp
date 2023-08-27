//
//  AuthManager.swift
//  Spotify
//
//  Created by Enes Sancar on 27.08.2023.
//

import Foundation

struct SpotifyConstants {
    static let clientID = "23a4e58662f94f4681e683c81dcde738"
    static let secretClientID = "49ee5c96aa8449339db1a127c0e9e8ca"
    static let tokenAPIURL = "https://accounts.spotify.com/api/token"
    static let baseURL = "https://accounts.spotify.com/"
    static let redirectURI = "https://open.spotify.com/"
    static let urlEncoded = "application/x-www-form-urlencoded"
    static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
}

final class AuthManager {
    static let shared = AuthManager()
    private var refreshingToken = false
    
    private init() {}
    
    public var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(SpotifyConstants.clientID)&scope=\(SpotifyConstants.scopes)&redirect_uri=\(SpotifyConstants.redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func exchangeCodeForToken(
        code: String,
        completion: @escaping ((Bool) -> Void)
    ) {
        // Get Token
        guard let url = URL(string: SpotifyConstants.tokenAPIURL) else {
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "authorization_code"),
            URLQueryItem(name: "code",
                         value: code),
            URLQueryItem(name: "redirect_uri",
                         value: SpotifyConstants.redirectURI),
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = SpotifyConstants.clientID+":"+SpotifyConstants.secretClientID
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)",
                         forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data,
                  error == nil else {
                completion(false)
                return
            }
            /*
             do {
             let result = try JSONDecoder().decode(AuthResponse.self, from: data)
             self?.cacheToken(result: result)
             completion(true)
             }
             catch {
             print(error.localizedDescription)
             completion(false)
             }
             }
             task.resume()
             }
             
             private var onRefreshBlocks = [((String) -> Void)]()
             
             /// Supplies valid token to be used with API Calls
             public func withValidToken(completion: @escaping (String) -> Void) {
             guard !refreshingToken else {
             // Append the compleiton
             onRefreshBlocks.append(completion)
             return
             }
             
             if shouldRefreshToken {
             // Refresh
             refreshIfNeeded { [weak self] success in
             if let token = self?.accessToken, success {
             completion(token)
             }
             }
             }
             else if let token = accessToken {
             completion(token)
             }
             }
             
             public func refreshIfNeeded(completion: ((Bool) -> Void)?) {
             guard !refreshingToken else {
             return
             }
             
             guard shouldRefreshToken else {
             completion?(true)
             return
             }
             
             guard let refreshToken = self.refreshToken else{
             return
             }
             
             // Refresh the token
             guard let url = URL(string: SpotifyConstants.tokenAPIURL) else {
             return
             }
             
             refreshingToken = true
             
             var components = URLComponents()
             components.queryItems = [
             URLQueryItem(name: "grant_type",
             value: "refresh_token"),
             URLQueryItem(name: "refresh_token",
             value: refreshToken),
             ]
             
             var request = URLRequest(url: url)
             request.httpMethod = "POST"
             request.setValue("application/x-www-form-urlencoded ",
             forHTTPHeaderField: "Content-Type")
             request.httpBody = components.query?.data(using: .utf8)
             
             let basicToken = SpotifyConstants.clientID+":"+SpotifyConstants.secretClientID
             let data = basicToken.data(using: .utf8)
             guard let base64String = data?.base64EncodedString() else {
             print("Failure to get base64")
             completion?(false)
             return
             }
             
             request.setValue("Basic \(base64String)",
             forHTTPHeaderField: "Authorization")
             
             let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
             self?.refreshingToken = false
             guard let data = data,
             error == nil else {
             completion?(false)
             return
             }
             
             do {
             let result = try JSONDecoder().decode(AuthResponse.self, from: data)
             self?.onRefreshBlocks.forEach { $0(result.accessToken!) }
             self?.onRefreshBlocks.removeAll()
             self?.cacheToken(result: result)
             completion?(true)
             }
             catch {
             print(error.localizedDescription)
             completion?(false)
             }
             }
             task.resume()
             }
             
             
             private func cacheToken(result: AuthResponse) {
             UserDefaults.standard.setValue(result.accessToken, forKey: UserDefaultsKeys.accessToken.rawValue)
             
             if let refreshToken = result.refreshToken {
             UserDefaults.standard.setValue(refreshToken, forKey: UserDefaultsKeys.refreshToken.rawValue)
             }
             
             UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expiresInSecond ?? 1000000)), forKey: UserDefaultsKeys.expirationDate.rawValue)
             
             
             }
             
             enum UserDefaultsKeys: String {
             case accessToken = "access_token"
             case refreshToken = "refresh_token"
             case expirationDate = "expirationDate"
             }
             */
        }
    }
}
