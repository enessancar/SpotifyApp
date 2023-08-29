//
//  APICaller.swift
//  Spotify
//
//  Created by Enes Sancar on 27.08.2023.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    public func getCurrentUserProfile(completion: @escaping(Result<UserProfile, CustomError>) -> ()) {
        AuthManager.shared.withValidToken { token in
            self.createRequest(with: URL(string: SpotifyConstants.baseURL + "me"),
                          type: .GET) { baseRequest in
                let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                    guard let data, error == nil else {
                        completion(.failure(.invalidData))
                        return
                    }
                    do {
                        let result = try JSONDecoder().decode(UserProfile.self, from: data)
                        print(result.email)
                    } catch {
                        completion(.failure(.unableToParseFromJSON))
                    }
                }
                task.resume()
            }
        }
    }
    
    private func createRequest(with url: URL?,
                               type: HTTPMethod,
                               completion: @escaping(URLRequest) -> ()) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else { return }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
