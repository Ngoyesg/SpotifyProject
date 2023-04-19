//
//  PlistReaderTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 11/06/22.
//

import XCTest
@testable import gndjf


class PlistReaderTests: XCTestCase {
    
    private var sut: PlistReader!
    
    override func setUp() {
        super.setUp()
        sut = PlistReader()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_initializeIsExecuted_GIVEN_someInvalidPlistPath_THEN_itShouldThrowError() throws {
        let invalistPlistName = "InvalidPlistName"
        
        do {
            let plist = try sut.readPlist(with: invalistPlistName)
            XCTFail()
        } catch let errorThrown {
            XCTAssertEqual(errorThrown as? PlistReader.Error, PlistReader.Error.invalidPlistPath)
        }
    }
    
    func test_WHEN_initializeIsExecuted_GIVEN_someValidPlistFileAndPath_THEN_itShouldReturnPlistContents() throws {
        let plistContents = try sut.readPlist(with: SpotifyAuthParamsBuilder.Constant.plistPath)
        XCTAssertEqual(plistContents["consumerKey"] as! String, "35e535d3d7b146d187248b4fe1aa31b4")
    }
    
    func test_WHEN_initializeIsExecuted_GIVEN_someInvalidPlistPath_THEN_itShouldThrowInvalidPlistPathError() {
        let invalistPlistName = "InvalidPlistName"
        do {
            let plist = try sut.readPlist(with: invalistPlistName)
            XCTFail()
        } catch let errorThrown {
            XCTAssertEqual(errorThrown as? PlistReader.Error, PlistReader.Error.invalidPlistPath)
        }
    }
}
