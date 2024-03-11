//
//  RegistrationViewController.swift
//  FireChatX
//
//  Created by A'zamjon Abdumuxtorov on 09/03/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var paswordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registrButton(_ sender: Any) {
        if let email = emailTF.text, let password = paswordTF.text{
            Firestore.firestore().createUserFirebase(email: email, password: password) { error, result in
                if let error = error{
                    self.showAlertAction(title: "\(error.localizedDescription)")
                }else{
                    UserDefaults.standard.setUserEmail(email: email)
                    UserDefaults.standard.setUserAuthorized()
                    self.vcSceneDelegate()?.setChatVcAsRootVc()
                }
            }
        }
    }
    
    
    
}
