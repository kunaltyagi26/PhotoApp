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
    
    func signup(withForm formModel: SignupFormRequestModel, completion: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        isSignupMethodCalled = true
    }
}
