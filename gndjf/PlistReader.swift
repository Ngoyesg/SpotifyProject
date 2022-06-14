//
//  ConfigurePlistManager.swift
//  gndjf
//
//  Created by Natalia Goyes on 7/06/22.
//

import Foundation

protocol PlistReaderProtocol: AnyObject {
    func readPlist(with filePath: String) throws -> [String: Any]
}

class PlistReader {
    struct Constant {
        static let plistExtension = "plist"
    }
    enum Error: Swift.Error {
        case invalidPlistPath, corruptedPlist
    }
}

extension PlistReader: PlistReaderProtocol {
    func readPlist(with filePath: String) throws -> [String: Any] {
        guard let spotifyConfigPlistPath = Bundle.main.url(forResource: filePath, withExtension: Constant.plistExtension) else {
            throw PlistReader.Error.invalidPlistPath
        }
        do {
            let spotifyConfigPlistData = try Data(contentsOf: spotifyConfigPlistPath)
            if let dict = try PropertyListSerialization.propertyList(from: spotifyConfigPlistData, options: [], format: nil) as? [String: Any] {
                return dict
            } else {
                throw PlistReader.Error.corruptedPlist
            }
        } catch let error {
            print(error.localizedDescription)
            throw PlistReader.Error.corruptedPlist
        }
    }
}
