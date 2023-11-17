//
//  APIService.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 14/11/2023.
//

import Foundation

class APIService {
    
    
   
    func fetchAlbums(searchTerm: String, page: Int, limit: Int, completion: @escaping( Result<AlbumResult,APIError> ) -> Void )  {
        let url = createURL(for: searchTerm, type: .album, page: page, limit: limit)
        fetch(type: AlbumResult.self, url: url, completion: completion)
        print("Albums url: \(url!)")
        
    }
    
    
    // the function below calls the API to fetch other song in an album when a particular song is selected
    func fetchAlbums(for Albumid: Int, completion: @escaping( Result<AlbumResult,APIError> ) -> Void) {
        let url = createURL(for: Albumid, type: .album)
        fetch(type: AlbumResult.self, url: url, completion: completion)
    }
    
    
// the below function calls the APi to fetch for songs in an Album when selected
    func fetchSongs(for albumID: Int, completion: @escaping( Result<SongResult,APIError> ) -> Void) {
        let url = createURL(for: albumID, type: .song)
        fetch(type: SongResult.self, url: url, completion: completion)
    }
    
    func fetchSongs(searchTerm: String, page: Int, limit: Int, completion: @escaping( Result<SongResult,APIError> ) -> Void )  {
        let url = createURL(for: searchTerm, type: .song, page: page, limit: limit)
        fetch(type: SongResult.self, url: url, completion: completion)
    }
    
    func fetchMovies(searchTerm: String, completion: @escaping( Result<MovieResult,APIError> ) -> Void )  {
        let url = createURL(for: searchTerm, type: .movie, page: nil, limit: nil)
        fetch(type: MovieResult.self, url: url, completion: completion)
        print("Moive url: \(url!)")
    }
    
    
    func fetch<T:Decodable>(type: T.Type, url: URL?, completion: @escaping( Result<T,APIError> ) -> Void) {
      
        guard let url = url else {
            let error = APIError.BadUrl
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.urlSession(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badRespons(response.statusCode)))
                
            } else if let data = data {
                
                do {
                    let result =  try JSONDecoder().decode(type, from: data)
                    completion(Result.success(result))
                } catch  {
                    completion(Result.failure(APIError.decoding(error as? DecodingError)))
                }
                
            }
            
        }.resume()

    }
    
    
    
    func createURL(for searchTerm: String, type: EntityType, page: Int?, limit: Int? ) -> URL? {
        // https://itunes.apple.com/search?term=jack+johnson&entity=album&lmit=5

        let BaseUrl = "https://itunes.apple.com/search"
        var  queryItems = [ URLQueryItem(name: "term", value: searchTerm),
                           URLQueryItem(name: "entity", value: type.rawValue) ]
        if let page = page, let limit = limit {
            let offset = page * limit
            queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
            queryItems.append( URLQueryItem(name: "offset", value: String(offset)))
        }
        
        var components = URLComponents(string: BaseUrl)
        components?.queryItems = queryItems
        return components?.url
    }
    
    
    
// the below function calls the APi to fetch for songs in an Album when selected
    func createURL(for id: Int,type: EntityType) -> URL? {
        // https://itunes.apple.com/lookup?id=909253&entity=album.
        let BaseUrl = "https://itunes.apple.com/lookup"
        
        var  queryItems = [ URLQueryItem(name: "id", value: String(id)),
                           URLQueryItem(name: "entity", value: type.rawValue) ]
        
        var components = URLComponents(string: BaseUrl)
        components?.queryItems = queryItems
        return components?.url
    }
    
}
