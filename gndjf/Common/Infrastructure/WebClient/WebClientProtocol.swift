//
//  WebClient.swift
//  gndjf
//
//  Created by Natalia Goyes on 15/07/22.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum WebServiceError: Error {
    case unauthorizedRequest,
         noURLFound,
         noEndpointFound,

         invalidRequest,
         invalidStatusCodeResponse,
         noDataToDecode,
         
         errorDecodingData,
         errorEncodingData,
         searchFailed
}

protocol WebClientProtocol {
    func performRequest(request: URLRequest, onSuccess: @escaping (Data) -> Void, onError: @escaping (WebServiceError) -> Void)
}
