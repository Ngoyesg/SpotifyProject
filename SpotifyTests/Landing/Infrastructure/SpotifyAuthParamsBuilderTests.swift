//
//  SpotifyAuthParamsBuilderTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 13/06/22.
//

import XCTest
@testable import gndjf

class SpotifyAuthParamsBuilderTests: XCTestCase {

    private var sut: SpotifyAuthParamsBuilder!
    private var fakePlistReader: FakePlistReader!
    
    override func setUp() {
        super.setUp()
        fakePlistReader = FakePlistReader()
        sut = SpotifyAuthParamsBuilder(plistReader: fakePlistReader)
    }
    
    override func tearDown() {
        fakePlistReader = nil
        sut = nil
        super.tearDown()
    }

    func test_WHEN_getParamsIsExecuted_GIVEN_validPlistAndValidFields_THEN_itShouldReturnAuthParams() throws {
        self.fakePlistReader.fakeDict.updateValue("dummy", forKey: "consumerKey")
        self.fakePlistReader.fakeDict.updateValue("dummy", forKey: "consumerSecret")
        self.fakePlistReader.fakeDict.updateValue("dummy", forKey: "authorizeUrl")
        self.fakePlistReader.fakeDict.updateValue("dummy", forKey: "accessTokenUrl")
        self.fakePlistReader.fakeDict.updateValue("dummy", forKey: "responseType")
        
        let _ = try sut.getParams()
    }
    
    func test_WHEN_getParamsIsExecuted_GIVEN_validPlistAndInvalidFields_THEN_itShouldThrowParsingError() {
        self.fakePlistReader.fakeDict.updateValue("dummy", forKey: "consumerKey")
        self.fakePlistReader.fakeDict.updateValue("dummy", forKey: "consumerSecret")
        self.fakePlistReader.fakeDict.updateValue("dummy", forKey: "authorizeUrl")
        self.fakePlistReader.fakeDict.updateValue("dummy", forKey: "accessTokenUrl")
        
        do {
          let _ = try sut.getParams()
            XCTFail()
        } catch let error {
            XCTAssertEqual(error as! SpotifyAuthParamsBuilder.Error, SpotifyAuthParamsBuilder.Error.unableToParseData)
        }
    }
    
    func test_WHEN_getParamsIsExecuted_GIVEN_invalidPlist_THEN_itShouldThrowPlistFetchingError() {
        
        self.fakePlistReader.error = PlistReader.Error.corruptedPlist
        
        do {
            let _ = try sut.getParams()
            XCTFail()
        } catch let error {
            XCTAssertEqual(error as! SpotifyAuthParamsBuilder.Error, SpotifyAuthParamsBuilder.Error.unableToFetchPlist)
        }
    }
}
