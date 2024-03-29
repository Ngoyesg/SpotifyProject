//
//  FakeRESTClient.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 3/08/22.
//

import Foundation
@testable import gndjf

class FakeRESTClient: WebClientProtocol {
    
    private func getEncodedData() -> Data {
        let artistImages = [ArtistImages(height: 1, width: 1, url: "Foo URL")]
        let artistInfo = ArtistInformation(id: "Foo ID", images: artistImages, name: "Foo Artitst", popularity: 1, genres: ["Foo Genre"])
        let items = [artistInfo]
        let pagination = Pagination(items: items, href: nil, next: nil)
        let artistAPIResponse = ArtistLookUpAPIResponse(artists: pagination)
        let encoder = JSONEncoder()
        
        let encodedData = try! encoder.encode(artistAPIResponse.self)
        
        return encodedData
    }
        
    private func getUndecodableData() -> Data {
        let anyFooStruct = ArtistImages(height: 1, width: 1, url: "")
        let encoder = JSONEncoder()
        
        let encodedData = try! encoder.encode(anyFooStruct.self)
        
        return encodedData
    }
        
    
    var decodableDataCase: Bool = true
    var successCase: Bool = true
    
    func performRequest(request: URLRequest, onSuccess: @escaping (Data) -> Void, onError: @escaping (WebServiceError) -> Void) {
        
        if (successCase) {
            let dataToPass = decodableDataCase ? getEncodedData() : getUndecodableData()
            onSuccess(dataToPass)
        } else {
            onError(WebServiceError.invalidRequest)
        }
    }
    
}
