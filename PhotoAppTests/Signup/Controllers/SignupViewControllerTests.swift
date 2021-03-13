//
//  SignupViewControllerTests.swift
//  PhotoAppTests
//
//  Created by Kunal Tyagi on 11/03/21.
//

import XCTest
@testable import PhotoApp

class SignupViewControllerTests: XCTestCase {
    var sut: SignupViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "signupViewController") as? SignupViewController else { return }
        sut = vc
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSignupViewController_WhenCreated_HasRequiredTextFieldEmpty() throws {
        let firstNameTextField = try XCTUnwrap(sut.firstNameTextField, "The firstNameTextField is not connected to an IBOutlet.")
        let lastNameTextField = try XCTUnwrap(sut.lastNameTextField, "The lastNameTextField is not connected to an IBOutlet.")
        let emailTextField = try XCTUnwrap(sut.emailTextField, "The emailTextField is not connected to an IBOutlet.")
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "The passwordTextField is not connected to an IBOutlet.")
        let repeatPasswordTextField = try XCTUnwrap(sut.repeatPasswordTextField, "The repeatPasswordTextField is not connected to an IBOutlet.")
        
        XCTAssertEqual(firstNameTextField.text, "", "First name text field was not empty when the view controller loaded initially")
        XCTAssertEqual(lastNameTextField.text, "", "Last name text field was not empty when the view controller loaded initially")
        XCTAssertEqual(emailTextField.text, "", "Email address text field was not empty when the view controller loaded initially")
        XCTAssertEqual(passwordTextField.text, "", "Password text field was not empty when the view controller loaded initially")
        XCTAssertEqual(repeatPasswordTextField.text, "", "Repeat password text field was not empty when the view controller loaded initially")
    }
    
    func testSignupViewController_WhenCreated_HasSignupButtonAndAction() throws {
        // Arrange
        let signupButton = try XCTUnwrap(sut.signupButton, "Signup button does not have a referencing outlet.")
        
        // Act
        let signupButtonActions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "Signup button does not have actions assigned to it.")
        
        // Assert
        XCTAssertEqual(signupButtonActions.count, 1)
        XCTAssertEqual(signupButtonActions.first, "signupPressed:", "There is not action with name signupPressed assigned to signup button.")
    }
    
    func testSignupViewController_WhenSignupButtonPressed_InvokesSignupProcess() {
        // Arrange
        let mockSignupModelValidator = MockSignupModelValidator()
        let mockSignupWebService = MockSignupWebService()
        let delegate = MockSignupViewDelegate()
        let mockSignupPresenter = MockSignupPresenter(formModelValidator: mockSignupModelValidator, signupWebService: mockSignupWebService, delegate: delegate)
        sut.presenter = mockSignupPresenter
        
        // Act
        sut.signupButton.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertTrue(mockSignupPresenter.processUserSignupCalled, "processUserSignupCalled was not called on a presenter object when signup button was pressed in SignupViewController.")
    }
    
    func testSignupController_WhenCreated_HasEmailAddressContentTypeSet() throws {
        let emailTextField = try XCTUnwrap(sut.emailTextField, "Email address UITextField is not connected.")
        XCTAssertEqual(emailTextField.textContentType, UITextContentType.emailAddress, "Email address UITextField does not have an email address content type set.")
    }
    
    func testSignupController_WhenCreated_HasEmailAddressKeyboardTypeSet() throws {
        let emailTextField = try XCTUnwrap(sut.emailTextField, "Email address UITextField is not connected.")
        XCTAssertEqual(emailTextField.keyboardType, UIKeyboardType.emailAddress, "Email address UITextField does not have an email address keyboard type set.")
    }
    
    func testSignupController_WhenCreated_IsSecuredTextEntryField() throws {
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "Password UITextField is not connected.")
        XCTAssertTrue(passwordTextField.isSecureTextEntry, "Password UITextField is not a Secure text Entry Field.")
    }
}
