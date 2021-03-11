//
//  MockSignupWebService.swift
//  PhotoAppTests
//
//  Created by kunaltyagi on 11/03/21.
//

import Foundation
@testable import PhotoApp

class MockSignupWebService: SignupWebServiceProtocol {
    var isSignupMethodCalled: Bool = false
    var shouldShowError: Bool?
    
    func signup(withForm formModel: SignupFormRequestModel, completion: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        isSignupMethodCalled = true
        if let shouldShowError = shouldShowError, shouldShowError {
            completion(nil, SignupError.failedRequest(description: "Signup request was not successful."))
        } else {
            completion(SignupResponseModel(status: "Ok"), nil)
        }
    }
}
