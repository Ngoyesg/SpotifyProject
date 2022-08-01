//
//  URLRequestBuilder.swift
//  gndjf
//
//  Created by Natalia Goyes on 26/07/22.
//

import Foundation

protocol URLRequestBuilderProtocol: AnyObject {
    func buildRequest(for idToSearch: String?, type queryType: QueryType, authorization token: String?) throws -> URLRequest
}

class URLRequestBuilder {
    
    enum Error: Swift.Error {
        case emptyRequest, unauthorized, invalidURL
    }
    
}
extension URLRequestBuilder: URLRequestBuilderProtocol {
    
    func buildRequest(for idToSearch: String?, type queryType: QueryType, authorization token: String?) throws -> URLRequest {
        
        guard let idToSearch = idToSearch else {
            throw URLRequestBuilder.Error.emptyRequest
        }
        
        guard let token = token else {
            throw URLRequestBuilder.Error.unauthorized
        }
        
        guard let url =  URLComponents(search: idToSearch, for: queryType).url else {
            throw URLRequestBuilder.Error.invalidURL
        }
        
        return URLRequest(authorization: token, for: url)
    }
}
