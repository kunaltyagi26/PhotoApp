//
//  MockSignupPresenter.swift
//  PhotoAppTests
//
//  Created by kunaltyagi on 12/03/21.
//

import Foundation
@testable import PhotoApp

class MockSignupPresenter: SignupPresenterProtocol {
    var processUserSignupCalled = false
    
    func processUserSignup(formModel: SignupFormModel) {
        processUserSignupCalled = true
    }
    
    required init(formModelValidator: SignupFormModelValidatorProtocol, signupWebService: SignupWebServiceProtocol, delegate: SignupViewDelegateProtocol) {
        
    }
}
