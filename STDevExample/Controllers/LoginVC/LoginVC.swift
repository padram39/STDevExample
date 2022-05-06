//
//  LoginVC.swift
//  STDevExample
//
//  Created by enigma 2 on 2/16/1401 AP.
//

import UIKit
import TweeTextField
import SwiftUI

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserSettings.isLogin = false
        passwordTxt.isSecureTextEntry = true
    }
    

    @IBAction func loginBtnPressed(_ sender: Any) {
        
        
        let email = usernameTxt.text
        let pass = passwordTxt.text
        
        if pass?.count ?? 0 < 8 {
            let alert = UIAlertController(title: "Password Problem", message: "Enter at least 8 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        if email?.isValidEmail() ?? false{
            InternetServices.shared.loginUser(email: email!, password: pass!) { success in
                print(success)
                UserSettings.username = email!
                let vc = StoryboardHandler.shared.child(withIdentifier: "mainVC")
                vc?.modalPresentationStyle = .fullScreen
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "Email not valid", message: "Enter a valid email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}
