//
//  FirebaseHelper.swift
//  FireChatX
//
//  Created by A'zamjon Abdumuxtorov on 11/03/24.
//

import FirebaseAuth
import FirebaseFirestore

extension Firestore{
    
    func createUserFirebase(email:String,password:String, complateHandler: @escaping(_ error: Error?, _ result: AuthDataResult?)->()){
        Auth.auth().createUser(withEmail: email, password: password){ result , error in
            complateHandler(error,result)
            
        }
    }
    
    func signInFirebase(email:String,password:String, complateHandler: @escaping(_ error: Error?, _ result: AuthDataResult?)->()){
        Auth.auth().signIn(withEmail: email, password: password){ result , error in
            complateHandler(error,result)
        }
    }
    
    func sendMessage(message:String?,complitionHandler:  @escaping(_ error: Error?, _ response: Message?)->()){
        let senderEmail = UserDefaults.standard.getUserEmail()
        
        guard let body = message else {return}
        
//        sender = data[Constants.sender] as? String, let body = data[Constants.body]
        
        let data:[String : Any] = [
            Constants.sender: senderEmail,
            Constants.body: body,
            Constants.date: Date().timeIntervalSince1970
        ]
        
        Firestore.firestore().collection(Constants.messages).addDocument(data: data){ error in
            if let error = error{
                complitionHandler(error,nil)
                return
            }else{
                complitionHandler(nil,Message(sender: senderEmail, message: body))
            }
            
        }
    }
    
    
    func listenMessages(complitionHandler:@escaping (_ error: Error? , _ messages: [Message]?)->()){
        Firestore.firestore().collection(Constants.messages)
            .order(by: Constants.date)
            .addSnapshotListener { quarySnapshot, error in
                if let error = error {
                    complitionHandler(error,nil)
                    return
                }
                
                var messages: [Message] = []
                
                guard let snapshotMessages = quarySnapshot?.documents else {
                    complitionHandler(nil,messages)
                    return
                }
                
                for doc in snapshotMessages{
                    let data = doc.data()
                    
                    guard let messageSender = data[Constants.sender] as? String,let messageBody = data[Constants.body] as? String else{continue}
                    let newMessage = Message(sender: messageSender, message: messageBody)
                    
                    messages.append(newMessage)
                }
                
                complitionHandler(nil, messages)
            }
    }
}

