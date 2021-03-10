//
//  MatchpointChatViewController.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 13/2/21.
//

import Foundation
import MessageKit
import Alamofire
import InputBarAccessoryView


class MatchpointChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate{
    
    var messages : [ChatMessage] = []
    var chat: Chat?
    let bgImage = UIImageView()
    var matchpointMessages : [MatchpointMessage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        bgImage.image = UIImage (named: "resul-DbwYNr8RPbg-unsplash")
        bgImage.contentMode = .scaleToFill
        messagesCollectionView.backgroundView = bgImage
        
        for player in self.chat!.participants{
            if player.id != Int(self.view.getUser().playerId!) {
                self.title = player.name
            }
        }
        self.messageInputBar.inputTextView.placeholder = "Escribe aquí..."
        
        self.fetchMessages()
    }
    
    
    func currentSender() -> SenderType {
        return Sender(senderId: self.view.getUser().playerId!, displayName:"NAME")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        messages.count
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        avatarView.loadPic(matchpointMessages[indexPath.section].sender.picture)
    }
    
    func fetchMessages() {
        
        let authHeaders = HTTPHeader.authorization(bearerToken: self.view.getUser().jwtToken!)

        AF.request(BASE_URL+CHAT_URL+String(chat!.id)+MESSAGES_URL, headers: [authHeaders]).responseDecodable { (response: DataResponse<[MatchpointMessage], AFError>) in
            
//            self.viewModel.users.removeAll()
//            for player in self.chat!.participants{
//                let newUser = User(id: player.id, name: player.name, avatarURL: nil)
//                self.viewModel.users.append(newUser)
//            }
            
            self.messages.removeAll()
            self.matchpointMessages = response.value!
            for message in self.matchpointMessages{
                
                let sender = ChatMessageSender(senderId: String(message.sender.id), displayName: message.sender.name)
                
                let newMessage = ChatMessage(sender: sender, messageId: String(message.id), sentDate: Date(), kind: MessageKind.text(message.content))
                            
                self.messages.append(newMessage)
            }
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToLastItem()
        }
    }
    
    @objc
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
       
        let url : String = BASE_URL+CHAT_URL+String(self.chat!.id)+MESSAGES_URL
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        let start = dateFormatter.string(from: self.startBooking!)
//        let end = dateFormatter.string(from: self.endBooking!)

        var receiver_id : Int = 0
        
        for player in self.chat!.participants{
            if player.id != Int(self.view.getUser().playerId!) {
                receiver_id = player.id
            }
        }
        
        let parameters: Parameters = ["receiver_id": String(receiver_id), "content": text]
        let authHeaders = HTTPHeader.authorization(bearerToken: self.view.getUser().jwtToken!)
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [authHeaders]).responseJSON { response in
            self.dismiss(animated: true) {
                print("TODO OK!")
                inputBar.inputTextView.text = String()
                inputBar.inputTextView.placeholder = "Escribe aquí..."
                self.fetchMessages()
            }
        }
        
    }
}
