//
//  BaseEndpoint.swift
//  gndjf
//
//  Created by Natalia Goyes on 1/08/22.
//

import Foundation

class BaseEndpoint {
    
    let host: String = "http://api.spotify.com"
    let path: String
    let queryItems: [URLQueryItem]
    let httpMethod: HTTPMethod
    
    init(path: String, queryItems: [URLQueryItem], httpMethod: HTTPMethod) {
        self.path = path
        self.queryItems = queryItems
        self.httpMethod = httpMethod
    }
    
    func getURL() -> URL? {
        
        var components = URLComponents()
        components.host = self.host
        components.path = self.path
        components.queryItems = self.queryItems
        
       return components.url
    }
}

class ArtistEndpoint: BaseEndpoint {
    
    struct Constant {
        static let path = "/v1/search"
        static let questIdentifier = "q"
        static let endpointType = "type"
        static let searchType = "artist"
    }
    
    init(search artist: String){
        let queryItems = [URLQueryItem(name: Constant.questIdentifier, value: artist), URLQueryItem(name: Constant.endpointType, value: Constant.searchType)]
        super.init(path: Constant.path, queryItems: queryItems, httpMethod: .GET)
    }
    
}

class AlbumsEndpoint: BaseEndpoint {
    
    struct Constant {
        static let path = "/v1/artists/"
        static let questIdentifier = ""
        static let separator = "/"
        static let searchType = "albums"
    }
    
    init(search albums: String){
        let queryItems = [URLQueryItem(name: Constant.questIdentifier, value: albums), URLQueryItem(name: Constant.separator, value: Constant.searchType)]
        super.init(path: Constant.path, queryItems: queryItems, httpMethod: .GET)
    }
    
}

class AlbumDetailEndpoint: BaseEndpoint {
    
    struct Constant {
        static let path = "/v1/albums/"
        static let questIdentifier = ""
        static let separator = "/"
        static let searchType = "tracks"
    }
    
    init(search albums: String){
        let queryItems = [URLQueryItem(name: Constant.questIdentifier, value: albums), URLQueryItem(name: Constant.separator, value: Constant.searchType)]
        super.init(path: Constant.path, queryItems: queryItems, httpMethod: .GET)
    }
    
}
