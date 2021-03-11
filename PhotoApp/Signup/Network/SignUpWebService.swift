//
//  SignUpWebService.swift
//  PhotoApp
//
//  Created by kunaltyagi on 19/02/21.
//

import Foundation

class SignUpWebService: SignupWebServiceProtocol {
    private let urlString: String
    private var urlSession: URLSession
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func signup(withForm formModel: SignupFormRequestModel, completion: @escaping(SignupResponseModel?, SignupError?)-> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, SignupError.invalidRequestURLString)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(formModel)
        urlSession.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    let response = try JSONDecoder().decode(SignupResponseModel.self, from: data)
                    completion(response, nil)
                } catch {
                    completion(nil, SignupError.responseModelParsingError)
                }
            } else if let error = error {
                completion(nil, SignupError.failedRequest(description: error.localizedDescription))
            }
        }.resume()
    }
}
