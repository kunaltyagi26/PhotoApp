//
//  SignupPresenterTests.swift
//  PhotoAppTests
//
//  Created by kunaltyagi on 11/03/21.
//

import XCTest
@testable import PhotoApp

class SignupPresenterTests: XCTestCase {
    var signupFormModel: SignupFormModel!
    var mockSignupModelValidiator: MockSignupModelValidator!
    var sut: SignupPresenter!
    var mockSignupWebService: MockSignupWebService!

    override func setUpWithError() throws {
        signupFormModel = SignupFormModel(firstName: "Sergey",
                                              lastName: "Kargopolov",
                                              email: "test@test.com",
                                              password:"12345678",
                                              repeatPassword:"12345678")
        mockSignupModelValidiator = MockSignupModelValidator()
        mockSignupWebService = MockSignupWebService()
        sut = SignupPresenter(formModelValidator: mockSignupModelValidiator, signupWebService: mockSignupWebService)
    }

    override func tearDownWithError() throws {
        signupFormModel = nil
        mockSignupModelValidiator = nil
        sut = nil
        mockSignupWebService = nil
    }

    func testSignupPresenter_WhenInformationProvided_WillValidateEachProperty() {
        // Arrange
        
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        
        // Assert
        
        XCTAssertTrue(mockSignupModelValidiator.isFirstNameValidated, "First name was not validated.")
        XCTAssertTrue(mockSignupModelValidiator.isLastNameValidated, "Last name was not validated.")
        XCTAssertTrue(mockSignupModelValidiator.isEmailValidated, "Email format was not validated.")
        XCTAssertTrue(mockSignupModelValidiator.isPasswordValidated, "Password was not validated.")
        XCTAssertTrue(mockSignupModelValidiator.isPasswordEqualityValidated, "Did not validate if passwords match.")
    }
    
    func testSignupPresenter_WhenGivenValidFormModel_ShouldCallSignupMethod() {
        // Arrange
        
        // Act
        
        sut.processUserSignup(formModel: signupFormModel)
        
        // Assert
        
        XCTAssertTrue(mockSignupWebService.isSignupMethodCalled, "The signup method was not called in the SignupWebService class.")
    }
    
    func testSignupPresenter_WhenSignupOperationSuccessful_CallsSuccessOnViewDelegate() {
        // Arrange
        let myExpectation = expectation(description: "Expected the successfulSignup() method to be called.")
        let mockSignupViewDelegate = MockSignupViewDelegate()
        mockSignupViewDelegate.expectation = myExpectation
        
        // Act
        self.wait(for: [myExpectation], timeout: 5.0)
        
        // Assert
    }
}
