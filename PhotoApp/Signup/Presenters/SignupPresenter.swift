//
//  SignupPresenter.swift
//  PhotoApp
//
//  Created by kunaltyagi on 11/03/21.
//

import Foundation

class SignupPresenter: SignupPresenterProtocol {
    private var formModelValidator: SignupFormModelValidatorProtocol
    private var signupWebService: SignupWebServiceProtocol
    private weak var delegate: SignupViewDelegateProtocol?
    
    required init(formModelValidator: SignupFormModelValidatorProtocol, signupWebService: SignupWebServiceProtocol, delegate: SignupViewDelegateProtocol) {
        self.formModelValidator = formModelValidator
        self.signupWebService = signupWebService
        self.delegate = delegate
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        if !formModelValidator.isFirstNameValid(firstName: formModel.firstName) {
            return
        }
        
        if !formModelValidator.isLastNameValid(lastName: formModel.lastName) {
            return
        }
        
        if !formModelValidator.isValidEmailFormat(email: formModel.email) {
            return
        }
        
        if !formModelValidator.isPasswordValid(password: formModel.password) {
            return
        }
        
        if !formModelValidator.doPasswordsMatch(password: formModel.password, repeatPassword: formModel.repeatPassword) {
            return
        }
        
        let signupFormRequestModel = SignupFormRequestModel(firstName: formModel.firstName, lastName: formModel.lastName, email: formModel.email, password: formModel.password)
        signupWebService.signup(withForm: signupFormRequestModel) { (signupResponse, signUpError) in
            if let _ = signupResponse {
                self.delegate?.successfulSignup()
            } else if let signUpError = signUpError {
                self.delegate?.errorHandler(error: signUpError)
            }
        }
    }
}
