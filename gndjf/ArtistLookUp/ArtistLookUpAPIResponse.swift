//
//  ArtistLookUpAPIResponse.swift
//  gndjf
//
//  Created by Natalia Goyes on 15/07/22.
//

import Foundation

struct ArtistLookUpAPIResponse: Codable, Equatable {
    let artists: Pagination
}

struct Pagination: Codable, Equatable {
    let items: [ArtistInformation]
    let href: String?
    let next: String?
}

struct ArtistInformation: Codable, Equatable {

    let id: String
    let images: [ArtistImages]
    let name: String
    let popularity: Int
    let genres: [String]
    
    static func == (lhs: ArtistInformation, rhs: ArtistInformation) -> Bool {
        if lhs.id == rhs.id, lhs.images == rhs.images, lhs.name == rhs.name, lhs.popularity == rhs.popularity, lhs.genres == rhs.genres {
            return true
        } else {
            return false
        }
    }
    
}

struct ArtistImages: Codable, Equatable {
    let height: Int
    let width: Int
    let url: String
    
    static func == (lhs: ArtistImages, rhs: ArtistImages) -> Bool {
        if lhs.height == rhs.height, lhs.width == rhs.width, lhs.url == rhs.url {
            return true
        } else {
            return false
        }
    }
}
