//
//  SpotifyAuthHandleBuilder.swift
//  gndjf
//
//  Created by Natalia Goyes on 13/06/22.
//

import Foundation

struct SpotifyScopeParams {
    let withCallbackURL: String
    let scope: String
    let state: Int
}

protocol SpotifyScopeParamsBuilderProtocol {
    func getParams() throws -> SpotifyScopeParams
}

class SpotifyScopeParamsBuilder {
    
    struct Constant {
        static let plistPath = "SpotifyScopeConfig"
        static let withCallbackURL = "withCallbackURL"
        static let scope = "scope"
        static let state = "state"
    }
    
    enum Error: Swift.Error {
        case unableToFetchPlist, unableToParseData
    }
    
    let plistReader: PlistReaderProtocol
    
    init(plistReader: PlistReaderProtocol) {
        self.plistReader = plistReader
    }
}

extension SpotifyScopeParamsBuilder: SpotifyScopeParamsBuilderProtocol {
    func getParams() throws -> SpotifyScopeParams {
        
        do {
            let spotifyPlist = try plistReader.readPlist(with: SpotifyScopeParamsBuilder.Constant.plistPath)
            if let withCallbackURL = spotifyPlist[SpotifyScopeParamsBuilder.Constant.withCallbackURL] as? String,
               let scope = spotifyPlist[SpotifyScopeParamsBuilder.Constant.scope] as? String,
               let state =  spotifyPlist[SpotifyScopeParamsBuilder.Constant.state] as? Int {

               return SpotifyScopeParams(
                    withCallbackURL: withCallbackURL,
                    scope: scope,
                    state: state)
            } else {
                throw SpotifyScopeParamsBuilder.Error.unableToParseData
            }
        } catch let error {
            print(error.localizedDescription)
            if let error = error as? SpotifyScopeParamsBuilder.Error, error == .unableToParseData {
                throw SpotifyScopeParamsBuilder.Error.unableToParseData
            }
            throw SpotifyScopeParamsBuilder.Error.unableToFetchPlist
        }
    }
}
