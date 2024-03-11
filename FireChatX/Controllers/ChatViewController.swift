//
//  ChatViewController.swift
//  FireChatX
//
//  Created by A'zamjon Abdumuxtorov on 09/03/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newMessageTF: UITextField!
    private let database = Firestore.firestore()
    private var messages : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        title = "Fire Chat"
        tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "messageCell")
        
        tableView.dataSource = self
        loadMessagesFB()
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserDefaults.standard.outUserAuthorized()
            self.vcSceneDelegate()?.setLogVcAsRootVc()
        } catch let signOutError as NSError {
            self.showAlertAction(title: "\(signOutError)")
            print("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func sendButton(_ sender: Any) {
        let messageBody = newMessageTF.text
        
        Firestore.firestore().sendMessage(message: messageBody) { error, response in
            if let error = error{
                self.showAlertAction(title: "\(error.localizedDescription)")
            }else{
                
                print("Saved")
            }
        }
        
        self.newMessageTF.text = ""
        
    }
    
    func loadMessagesFB(){
        
        Firestore.firestore().listenMessages { error, messages in
            if let error = error{
                self.showAlertAction(title: "\(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                self.messages.removeAll()
                self.messages.append(contentsOf: messages!)
                
                self.tableView.reloadData()
                let indexpath = IndexPath(row: self.messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: indexpath, at: .top, animated: false)
            }
        }
    
    }
    
}

extension ChatViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell",for: indexPath) as! MessageTableViewCell
        cell.configure(message: messages[indexPath.row])
        return cell
    }
    
    
}
