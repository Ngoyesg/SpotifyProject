//
//  OauthConfigurator.swift
//  gndjf
//
//  Created by Natalia Goyes on 6/06/22.
//

import Foundation
import OAuthSwift

protocol OauthConfiguratorProtocol: AnyObject {
    func getAuthentifier(with spotifyAuthParams: SpotifyAuthParams) -> OAuth2Swift
}

class OauthConfigurator {
}

extension OauthConfigurator: OauthConfiguratorProtocol {
    func getAuthentifier(with spotifyAuthParams: SpotifyAuthParams) -> OAuth2Swift {
        return OAuth2Swift(
                consumerKey: spotifyAuthParams.consumerKey,
                consumerSecret: spotifyAuthParams.consumerSecret,
                authorizeUrl: spotifyAuthParams.authorizeUrl,
                accessTokenUrl: spotifyAuthParams.accessTokenUrl as URLConvertible ,
                responseType: spotifyAuthParams.responseType,
                contentType: nil)
    }
}
