//
//  SignupErrors.swift
//  PhotoApp
//
//  Created by kunaltyagi on 19/02/21.
//

import Foundation

enum SignupError: LocalizedError, Equatable {
    case responseModelParsingError
    case invalidRequestURLString
    case failedRequest(description: String)
    
    var errorDescription: String? {
        switch self {
            case .failedRequest(let description):
                return description
        case .invalidRequestURLString, .responseModelParsingError:
                return ""
        }
    }
}
