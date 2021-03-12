//
//  ViewController.swift
//  PhotoApp
//
//  Created by kunaltyagi on 16/02/21.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    var presenter: SignupPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil {
            let signupModelValidator = SignUpFormModelValidator()
            let signupWebService = SignUpWebService(urlString: SignupConstants.urlString)
            
            presenter = SignupPresenter(formModelValidator: signupModelValidator, signupWebService: signupWebService, delegate: self)
        }
    }

    @IBAction func signupPressed(_ sender: Any) {
        presenter?.processUserSignup(formModel: SignupFormModel(firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "", repeatPassword: repeatPasswordTextField.text ?? ""))
    }
}

extension SignupViewController: SignupViewDelegateProtocol {
    func successfulSignup() {
        
    }
    
    func errorHandler(error: SignupError) {
        
    }
    
    
}

