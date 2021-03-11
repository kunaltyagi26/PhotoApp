//
//  SignupWebServiceProtocol.swift
//  PhotoApp
//
//  Created by kunaltyagi on 11/03/21.
//

import Foundation

protocol SignupWebServiceProtocol {
    func signup(withForm formModel: SignupFormRequestModel, completion: @escaping(SignupResponseModel?, SignupError?)-> Void)
}
