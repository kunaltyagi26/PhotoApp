//
//  File.swift
//  PhotoApp
//
//  Created by kunaltyagi on 11/03/21.
//

import Foundation

protocol SignupFormModelValidatorProtocol {
    func isFirstNameValid(firstName: String)-> Bool
    func isLastNameValid(lastName: String) -> Bool
    func isValidEmailFormat(email: String) -> Bool
    func isPasswordValid(password: String) -> Bool
    func doPasswordsMatch(password: String, repeatPassword: String)-> Bool
}
