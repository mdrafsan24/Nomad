//
//  ViewController.swift
//  Nomad
//
//  Created by MD R CHOWDHURY on 10/24/20.
//  Copyright © 2020 MD R CHOWDHURY. All rights reserved.

import UIKit
import FirebaseAuth

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var emailtext: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBAction func signInPresseed(_ sender: UIButton) {
        if let email = emailtext.text, let password = passwordTxt.text {
            // @Issue dont allow users to sign into to tutor mode vice versa
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let firebaseError = error {
                    // If error != nil, then sets loginErrorLbl to the appropriate text
                    return
                }
                
                self.performSegue(withIdentifier: "goToMapVC", sender: self)
            }
        }
    }

}

