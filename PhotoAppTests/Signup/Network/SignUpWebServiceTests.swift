//
//  File.swift
//  PhotoAppTests
//
//  Created by kunaltyagi on 18/02/21.
//

import XCTest
@testable import PhotoApp

class SignUpWebServiceTests: XCTestCase {
    
    var sut: SignUpWebService!
    var signupFormRequestModel: SignupFormRequestModel!
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockingURLProtocol.self]
        let session = URLSession(configuration: config)
        sut = SignUpWebService(urlString: SignupConstants.urlString, urlSession: session)
        signupFormRequestModel = SignupFormRequestModel(firstName: "Sergey", lastName: "Kargopolov", email: "test@test.com", password: "12345678")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        signupFormRequestModel = nil
        MockingURLProtocol.stubResponseData = nil
        MockingURLProtocol.error = nil
    }
    
    func testSignUpWebService_WhenGivenSuccessfulResponse_ReturnsSuccess() {
        // Arrange
        let jsonString = "{\"status\":\"ok\"}"
        MockingURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Signup Web Service Response Expectation.")
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { (signupResponseModel, error) in
            // Assert
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignUpWebService_WhenReceivedDifferentJSONResponse_ErrorTookPlace() {
        // Arrange
        let jsonString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
        MockingURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "signup() method expectation for a response that has different JSON structure.")
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { (signupResponseModel, error) in
            // Assert
            XCTAssertNil(signupResponseModel, "The response model for a request containing unknown JSON response should have been nil.")
            XCTAssertEqual(error, SignupError.responseModelParsingError, "The signup() method didb't return expected error.")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignUpWebService_WhenEmptyURLStringProvided_ReturnsError() {
        // Arrange
        sut = SignUpWebService(urlString: "")
        
        let expectation = self.expectation(description: "An empty URL request expectation.")
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { (signupResponseModel, error) in
            // Assert
            XCTAssertEqual(error, SignupError.invalidRequestURLString, "The signup() method didn't return expected error for an invalidRequestURLStringError error.")
            XCTAssertNil(signupResponseModel, "The response model for a request containing invalid url should have been nil.")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testSignupWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        // Arrange
        let errorDescription = "A localized description of an error."
        MockingURLProtocol.error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])
        let expectation = self.expectation(description: "An failed request expectation.")
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { (signupResponseModel, error) in
            // Assert
            XCTAssertEqual(error, SignupError.failedRequest(description: errorDescription), "The signup() method didn't return expected error for an failedRequest error.")
            XCTAssertNil(signupResponseModel, "The response model for a request containing invalid url should have been nil.")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
        
        // Assert
    }
}
