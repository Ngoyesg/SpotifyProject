//
//  ArtistLookUpAPIResponse.swift
//  gndjf
//
//  Created by Natalia Goyes on 15/07/22.
//

import Foundation

struct ArtistLookUpAPIResponse: Codable {
    let artists: Pagination
}

struct Pagination: Codable {
    let items: [ArtistInformation]
    let href: String?
    let next: String?
}

struct ArtistInformation: Codable {
    let id: String
    let images: [ArtistImages]
    let name: String
    let popularity: Int
    let genres: [String]
}

struct ArtistImages: Codable {
    let height: Int
    let width: Int
    let url: String
}
