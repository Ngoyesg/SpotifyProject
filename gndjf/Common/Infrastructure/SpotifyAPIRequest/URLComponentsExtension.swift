//
//  URLComponentsExtension.swift
//  gndjf
//
//  Created by Natalia Goyes on 1/08/22.
//

import Foundation

extension URLComponents {
    
    init(search quest: String, for queryType: QueryType) {
        self.init()
        self.scheme = "https"
        self.host = "api.spotify.com"
        
        switch queryType {
        case .artist:
            self.path = "/v1/search"
            self.queryItems = [URLQueryItem(name: "q", value: quest), URLQueryItem(name: "type", value: "artist")]
        case .albums:
            self.path = "/v1/artists/"
            self.queryItems = [URLQueryItem(name: "", value: quest), URLQueryItem(name: "/", value: "albums")]
        case .albumDetail:
            self.path = "/v1/albums/"
            self.queryItems = [URLQueryItem(name: "", value: quest), URLQueryItem(name: "/", value: "tracks")]
        }
    }
}

