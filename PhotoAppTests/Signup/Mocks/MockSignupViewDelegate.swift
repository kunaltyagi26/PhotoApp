//
//  MockSignupViewDelegate.swift
//  PhotoAppTests
//
//  Created by kunaltyagi on 11/03/21.
//

import XCTest
@testable import PhotoApp

class MockSignupViewDelegate: SignupViewDelegateProtocol {
    var expectation: XCTestExpectation?
    var successfulSignupCounter: Int = 0
    var errorHandlerCounter: Int = 0
    var signUpError: SignupError?
    
    func successfulSignup() {
        successfulSignupCounter += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: SignupError) {
        errorHandlerCounter += 1
        signUpError = error
        expectation?.fulfill()
    }
}
