//
//  LoginViewModelTests.swift
//  NavigationUnitTests
//
//  Created by Vladislav Green on 3/1/23.
//

import XCTest

class UserModelDummy: UserService {
    var fakeUser = User(
        userLogin: "test",
        userFullName: "Fake User",
        userAvatar: UIImage(named: "cat")!,
        userStatus: "Testing user model"
        )

    func loginToProfile(ofUser: String) -> User? {
        ofUser == fakeUser.userLogin ? fakeUser : nil
    }
}

final class LoginViewModelTests: XCTestCase {
    
    var userTest: UserModelDummy!

    override func setUpWithError() throws {
        try super.setUpWithError()
        userTest = UserModelDummy()
    }

    override func tearDownWithError() throws {
        userTest = nil
        try super.tearDownWithError()
    }

    func testCaseUserExist() throws {
        let input = "test"
        let expectedOutput = userTest.fakeUser.userLogin
        
        let user = userTest.loginToProfile(ofUser: input)
        
        XCTAssertEqual(user?.userLogin, expectedOutput, "есть такой пользователь")
    }
    
    func testCaseUserDoesntExist() throws {
        let input = "wrong login"
        let expectedOutput = true
        
        let user = userTest.loginToProfile(ofUser: input)
        guard user == nil else {
            let loginIsFailed = false
            return
        }
        let loginIsFailed = true
        
        XCTAssertEqual(loginIsFailed, expectedOutput, "нет такого пользователя")
    }

}
