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
        let signupButton = try XCTUnwrap(sut.signupButton, "Signup button does not have a referencing outlet.")
        let signupButtonActions = signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside)
        XCTAssertEqual(signupButtonActions?.count, 1)
    }
}
