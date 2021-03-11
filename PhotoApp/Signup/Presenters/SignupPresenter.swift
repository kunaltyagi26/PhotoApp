//
//  SignupPresenter.swift
//  PhotoApp
//
//  Created by kunaltyagi on 11/03/21.
//

import Foundation

class SignupPresenter {
    private var formModelValidator: SignupFormModelValidatorProtocol
    private var signupWebService: SignupWebServiceProtocol
    
    init(formModelValidator: SignupFormModelValidatorProtocol, signupWebService: SignupWebServiceProtocol) {
        self.formModelValidator = formModelValidator
        self.signupWebService = signupWebService
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
            
        }
    }
}
