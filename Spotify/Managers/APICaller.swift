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
    
    //MARK: - Albums
    public func getAlbumDetails(for album: Album, completion: @escaping(Result<AlbumDetailsResponse, CustomError>) -> ()) {
        createRequest(
            with: URL(string: SpotifyConstants.baseAPIURL + "/albums/" + album.id),
            type: .GET) { request in
                let task = URLSession.shared.dataTask(with: request) { data, _, error in
                    guard let data, error == nil else {
                        completion(.failure(.invalidData))
                        return
                    }
                    do {
                        let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(.unableToParseFromJSON))
                    }
                }
                task.resume()
            }
    }
    
    //MARK: - Profile
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, CustomError>) -> Void) {
        createRequest(
            with: URL(string: SpotifyConstants.baseAPIURL + "/me"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(.invalidData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(.unableToParseFromJSON))
                }
            }
            task.resume()
        }
    }
    
    public func getNewReleases(completion: @escaping(Result<NewReleasesResponse, CustomError>) -> ()) {
        createRequest(with: URL(string: SpotifyConstants.baseAPIURL + "/browse/new-releases?limit=1"),
                      type: .GET) { request in
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data, error == nil else {
                    completion(.failure(.invalidData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.unableToParseFromJSON))
                }
            }.resume()
        }
    }
    
    public func getFeaturedPlaylists(completion: @escaping(Result<FeaturedPlaylistsResponse, CustomError>) -> ()) {
        createRequest(with: URL(string: SpotifyConstants.baseAPIURL + "/browse/featured-playlists?limit=2"),
                      type: .GET) { request in
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data, error == nil else {
                    completion(.failure(.invalidData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.unableToParseFromJSON))
                }
            }.resume()
        }
    }
    
    public func getRecommendations(genres: Set<String>, completion: @escaping(Result<RecommendationsResponse, CustomError>) -> ()) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: SpotifyConstants.baseAPIURL + "/recommendations?limit=2&seed_genres=\(seeds)"),
                      type: .GET) { request in
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data, error == nil else {
                    completion(.failure(.invalidData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.unableToParseFromJSON))
                }
            }.resume()
        }
    }
    
    public func getRecommendedGenres(completion: @escaping(Result<RecommendedGenresResponse, CustomError>) -> ()) {
        createRequest(with: URL(string: SpotifyConstants.baseAPIURL + "/recommendations/available-genre-seeds"),
                      type: .GET) { request in
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data, error == nil else {
                    completion(.failure(.invalidData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.unableToParseFromJSON))
                }
            }.resume()
        }
    }
    
    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
