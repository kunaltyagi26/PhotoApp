//
//  SignupPresenterProtocol.swift
//  PhotoApp
//
//  Created by kunaltyagi on 12/03/21.
//

import Foundation

protocol SignupPresenterProtocol {
    init(formModelValidator: SignupFormModelValidatorProtocol, signupWebService: SignupWebServiceProtocol, delegate: SignupViewDelegateProtocol)
    func processUserSignup(formModel: SignupFormModel)
}
