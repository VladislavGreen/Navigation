//
//  _FeedViewModelTests_.swift
//  NavigationUnitTests
//
//  Created by Vladislav Green on 2/28/23.
//

import XCTest

final class FeedViewModelTests: XCTestCase {
    
    var feedModel: FeedModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        feedModel = FeedModel()
    }

    override func tearDownWithError() throws {
        feedModel = nil
        try super.tearDownWithError()
    }

    func testThatEntersCorrectPassword() throws {
        
        // arrange
        let input = feedModel.password
        let expectedOutput = true
        // act
        
        // assert
        XCTAssertEqual(feedModel.check(word: input), expectedOutput, "пароль верный")
    }
    
    func testThatEntersIncorrectPassword() throws {
        let input = "somePassword"
        let expectedOutput = false
        XCTAssertEqual(feedModel.check(word: input), expectedOutput, "пароль не верный")
    }
    
    func testThatEntersEmptyPassword() throws {
        let input = ""
        let expectedOutput = false
        XCTAssertEqual(feedModel.check(word: input), expectedOutput, "пароль не верный")
    }
  
}
