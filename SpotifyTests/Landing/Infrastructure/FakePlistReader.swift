//
//  FakePlistReader.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 13/06/22.
//

import Foundation
@testable import gndjf

class FakePlistReader: PlistReaderProtocol {
    var fakeDict: [String : Any] = [:]
    var error: Error?
    
    func readPlist(with filePath: String) throws -> [String : Any] {
        if let error = self.error {
            throw error
        }
        return fakeDict
    }
    
}

