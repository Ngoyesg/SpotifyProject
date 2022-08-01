//
//  SpotifyQuery.swift
//  gndjf
//
//  Created by Natalia Goyes on 19/07/22.
//

import Foundation

enum QueryType: String {
    case artist, albums, albumDetail
}

struct UserQuery {
    let queryType: QueryType
    let idToSearch: String
}
