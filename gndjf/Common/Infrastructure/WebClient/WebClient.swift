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
    case emptyURL, unauthorizedRequest, invalidRequest, invalidStatusCodeResponse, noDataToDecode, errorDecodingData, errorEncodingData
}

protocol WebClient {
    func performRequest(request: URLRequest, onSuccess: @escaping (Data) -> (), onError: @escaping (WebServiceError) -> ())
}
