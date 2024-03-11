//
//  MessageTableViewCell.swift
//  FireChatX
//
//  Created by A'zamjon Abdumuxtorov on 09/03/24.
//

import UIKit
import FirebaseAuth

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var senderLB: UILabel!
    @IBOutlet weak var messageLB: UILabel!
    @IBOutlet weak var youLB: UILabel!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var useView: UIView!
    @IBOutlet weak var youView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
        // Initialization code
    }
    
    func initView(){
        messageView.layer.cornerRadius = messageView.frame.size.height/5
        useView.layer.cornerRadius = useView.frame.size.height/5
        youView.layer.cornerRadius = youView.frame.size.height/5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(message: Message){
        
        if Auth.auth().currentUser?.email == message.sender{
            youView.isHidden = true
            useView.isHidden = false
        }else{
            youView.isHidden = false
            useView.isHidden = true
        }
        
        messageLB.text = message.message
        
    }
}
