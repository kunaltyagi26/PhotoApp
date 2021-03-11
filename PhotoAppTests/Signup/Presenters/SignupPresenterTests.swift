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
    var mockSignupViewDelegate: MockSignupViewDelegate!

    override func setUpWithError() throws {
        signupFormModel = SignupFormModel(firstName: "Sergey",
                                              lastName: "Kargopolov",
                                              email: "test@test.com",
                                              password:"12345678",
                                              repeatPassword:"12345678")
        mockSignupModelValidiator = MockSignupModelValidator()
        mockSignupWebService = MockSignupWebService()
        mockSignupViewDelegate = MockSignupViewDelegate()
        sut = SignupPresenter(formModelValidator: mockSignupModelValidiator, signupWebService: mockSignupWebService, delegate: mockSignupViewDelegate)
    }

    override func tearDownWithError() throws {
        signupFormModel = nil
        mockSignupModelValidiator = nil
        sut = nil
        mockSignupWebService = nil
        mockSignupViewDelegate = nil
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
        mockSignupViewDelegate.expectation = myExpectation
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [myExpectation], timeout: 5.0)
        
        // Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 1, "successfulSignup() was called more than once.")
    }
    
    func testSignupPresenter_WhenSignupOperationSuccessful_ShouldCallErrorOnViewDelegate() {
        // Arrange
        let myExpectation = expectation(description: "Expected the errorHandler() method to be called.")
        mockSignupViewDelegate.expectation = myExpectation
        
        // Act
        mockSignupWebService.shouldShowError = true
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [myExpectation], timeout: 5.0)
        
        // Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 0)
        XCTAssertEqual(mockSignupViewDelegate.errorHandlerCounter, 1)
        XCTAssertNotNil(mockSignupViewDelegate.signUpError)
    }
}
