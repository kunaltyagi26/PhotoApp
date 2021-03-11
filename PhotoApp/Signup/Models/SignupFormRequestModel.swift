//
//  SignupFormRequestModel.swift
//  PhotoApp
//
//  Created by kunaltyagi on 19/02/21.
//

import Foundation

struct SignupFormRequestModel: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
