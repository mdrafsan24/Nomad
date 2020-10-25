//
//  CreateAccountVC.swift
//  Nomad
//
//  Created by MD R CHOWDHURY on 10/25/20.
//  Copyright © 2020 MD R CHOWDHURY. All rights reserved.
//

import UIKit

import FirebaseAuth

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func createAccountPressed(_ sender: UIButton) {
        beginSignUP()
    }
    func beginSignUP() {
        if let email = emailText.text, let password = passwordText.text {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let firebaseError = error {
                    print("Error signUpPressed @signUpPressed -->",firebaseError.localizedDescription)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    

}
