//
//  SpotifyAuthParamsBuilder.swift
//  gndjf
//
//  Created by Natalia Goyes on 11/06/22.
//

import Foundation

struct SpotifyAuthParams {
    let consumerKey: String
    let consumerSecret: String
    let authorizeUrl: String
    let accessTokenUrl: String
    let responseType: String
}

protocol SpotifyAuthParamsBuilderProtocol {
    func getParams() throws -> SpotifyAuthParams
}

class SpotifyAuthParamsBuilder {
    
    struct Constant {
        static let plistPath = "SpotifyOauthConfig"
        static let consumerKey = "consumerKey"
        static let consumerSecret = "consumerSecret"
        static let authorizeUrl = "authorizeUrl"
        static let accessTokenUrl = "accessTokenUrl"
        static let responseType = "responseType"
    }
    
    enum Error: Swift.Error {
        case unableToFetchPlist, unableToParseData
    }
    
    let plistReader: PlistReaderProtocol
    
    init(plistReader: PlistReaderProtocol) {
        self.plistReader = plistReader
    }
}

extension SpotifyAuthParamsBuilder: SpotifyAuthParamsBuilderProtocol {
    func getParams() throws -> SpotifyAuthParams {
        
        do {
            let spotifyPlist = try plistReader.readPlist(with: SpotifyAuthParamsBuilder.Constant.plistPath)
            if let consumerKey = spotifyPlist[SpotifyAuthParamsBuilder.Constant.consumerKey] as? String,
               let consumerSecret = spotifyPlist[SpotifyAuthParamsBuilder.Constant.consumerSecret] as? String,
               let authorizeUrl =  spotifyPlist[SpotifyAuthParamsBuilder.Constant.authorizeUrl] as? String,
               let accessTokenUrl = spotifyPlist[SpotifyAuthParamsBuilder.Constant.accessTokenUrl] as? String,
               let responseType = spotifyPlist[SpotifyAuthParamsBuilder.Constant.responseType] as? String {

                return SpotifyAuthParams(
                    consumerKey: consumerKey,
                    consumerSecret:  consumerSecret,
                    authorizeUrl: authorizeUrl,
                    accessTokenUrl: accessTokenUrl,
                    responseType: responseType)
            } else {
                throw SpotifyAuthParamsBuilder.Error.unableToParseData
            }
        } catch let error {
            print(error.localizedDescription)
            if let paramsError = error as? SpotifyAuthParamsBuilder.Error, paramsError == .unableToParseData {
                throw paramsError
            }
            throw SpotifyAuthParamsBuilder.Error.unableToFetchPlist
        }
    }
}
