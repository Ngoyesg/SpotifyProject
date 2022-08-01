//
//  URLRequestExtension.swift
//  gndjf
//
//  Created by Natalia Goyes on 1/08/22.
//

import Foundation

extension URLRequest {
    
    init(authorization token: String, for url: URL) {
        self.init(url: url)
        self.httpMethod = "GET"
        self.setValue("application/json", forHTTPHeaderField: "Accept")
        self.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.setValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
    }
}
