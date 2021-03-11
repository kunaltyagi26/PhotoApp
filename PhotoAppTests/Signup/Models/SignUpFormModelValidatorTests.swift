//
//  PhotoAppTests.swift
//  PhotoAppTests
//
//  Created by kunaltyagi on 16/02/21.
//

import XCTest
@testable import PhotoApp

class SignUpFormModelValidatorTests: XCTestCase {
    
    var sut: SignUpFormModelValidator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SignUpFormModelValidator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testSignUpFormModelValidator_WhenValidFirstNameIsProvided_ShouldReturnTrue() {
        // Arrange
        
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Sergey")
        
        // Assert
        
        XCTAssertTrue(isFirstNameValid, "The isFirstNameValid() should have returned TRUE for a valid first name but returned FALSE.")
    }
    
    func testSignUpFormModelValidation_WhenTooShortFirstNameProvided_shouldReturnFalse() {
        // Arrange
        
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "S")
        
        // Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE for a first name that is shorter than \(SignupConstants.firstNameMinLength) characters but it has returned TRUE.")
    }
    
    func testSignUpFormModelValidation_WhenTooLongFirstNameProvided_shouldReturnFalse() {
        
        // Arrange
        
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "SergeySergey")
        
        // Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE for a first name that is longer than \(SignupConstants.firstNameMaxLength) characters but it has returned TRUE.")
    }
    
    func testSignUpFormModelValidator_WhenValidLastNameIsProvided_ShouldReturnTrue() {
        // Arrange
        
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "Kargopolov")
        
        // Assert
        
        XCTAssertTrue(isLastNameValid, "The isLastNameValid() should have returned TRUE for a valid first name but returned FALSE.")
    }
    
    func testSignUpFormModelValidator_WhenShortLastNameIsProvided_ShouldReturnFalse() {
        // Arrange
        
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "K")
        
        // Assert
        
        XCTAssertFalse(isLastNameValid, "The isLastNameValid() should have returned FALSE for a valid first name but returned TRUE.")
    }
    
    func testSignUpFormModelValidator_WhenValidEmailIsProvided_ShouldReturnTrue() {
        // Arrange
        
        // Act
        let isEmailValid = sut.isValidEmailFormat(email: "abc@gmail.com")
        
        // Assert
        
        XCTAssertTrue(isEmailValid, "The isEmailValid() should have returned TRUE for a valid first name but returned FALSE.")
    }
    
    func testSignUpFormModelValidator_WhenValidPasswordIsProvided_ShouldReturnTrue() {
        // Arrange
        
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch(password: "abcd", repeatPassword: "abcd")
        
        // Assert
        
        XCTAssertTrue(doPasswordsMatch, "The doPasswordsMatch() should have returned TRUE for a valid password but returned FALSE.")
    }
    
    func testSignUpFormModelValidator_WhenInvalidValidPasswordIsProvided_ShouldReturnFalse() {
        // Arrange
        
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch(password: "abcd", repeatPassword: "abcde")
        
        // Assert
        
        XCTAssertFalse(doPasswordsMatch, "The doPasswordsMatch() should have returned FALSE for a invalid password but returned TRUE.")
    }
}
