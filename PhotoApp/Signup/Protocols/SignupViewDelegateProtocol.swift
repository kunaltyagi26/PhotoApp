//
//  SignupViewDelegateProtocol.swift
//  PhotoApp
//
//  Created by kunaltyagi on 11/03/21.
//

import Foundation

protocol SignupViewDelegateProtocol {
    func successfulSignup()
    func errorHandler(error: SignupError)
}
