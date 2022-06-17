//
//  SpotifyScopeParamsBuilderTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 13/06/22.
//

import XCTest
@testable import gndjf

class SpotifyScopeParamsBuilderTests: XCTestCase {

    private var sut: SpotifyScopeParamsBuilder!
    private var fakePlistReader: FakePlistReader!
    
    override func setUp() {
        super.setUp()
        fakePlistReader = FakePlistReader()
        sut = SpotifyScopeParamsBuilder(plistReader: fakePlistReader)
    }
    
    override func tearDown() {
        fakePlistReader = nil
        sut = nil
        super.tearDown()
    }

    func test_WHEN_getParamsIsExecuted_GIVEN_validPlistAndValidFields_THEN_itShouldReturnScopeParams() throws {
        self.fakePlistReader.fakeDict.updateValue("dummy", forKey: "withCallbackURL")
        self.fakePlistReader.fakeDict.updateValue("dummy", forKey: "scope")
        self.fakePlistReader.fakeDict.updateValue(1, forKey: "state")
        
        let _ = try sut.getParams()
    }
    
    func test_WHEN_getParamsIsExecuted_GIVEN_validPlistAndInvalidFields_THEN_itShouldThrowParsingError() {
        self.fakePlistReader.fakeDict.updateValue("dummy", forKey: "withCallbackURL")
        self.fakePlistReader.fakeDict.updateValue("dummy", forKey: "scope")
        
        do {
          let _ = try sut.getParams()
            XCTFail()
        } catch let error {
            XCTAssertEqual(error as! SpotifyScopeParamsBuilder.Error, SpotifyScopeParamsBuilder.Error.unableToParseData)
        }
    }
    
    func test_WHEN_getParamsIsExecuted_GIVEN_invalidPlist_THEN_itShouldThrowPlistFetchingError() {
        
        self.fakePlistReader.error = PlistReader.Error.corruptedPlist
        
        do {
            let _ = try sut.getParams()
            XCTFail()
        } catch let error {
            XCTAssertEqual(error as! SpotifyScopeParamsBuilder.Error, SpotifyScopeParamsBuilder.Error.unableToFetchPlist)
        }
    }

}
