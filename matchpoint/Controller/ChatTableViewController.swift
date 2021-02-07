//
//  ChatTableViewController.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 28/1/21.
//

import UIKit
import Alamofire

class ChatTableViewController: UITableViewController {
    
    var chats: [Chat] = []
    var selectedRow : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemBlue
        
        fetchChats()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var participant : Player = self.chats[0].participants[0]
        let myId = 1
        
        for player in self.chats[indexPath.row].participants {
            if player.id != myId {
                participant = player
            }
        }
        
        cell.textLabel?.text = participant.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
        selectedRow = indexPath.row
        self.performSegue(withIdentifier: "MessageSegue", sender: self.chats[indexPath.row])
    }
    
    func fetchChats() {
        
        let url : String = BASE_URL+PLAYER_URL+"1"+CHAT_URL
        debugPrint(url)
        
        AF.request(url).responseDecodable { (response: DataResponse<[Chat], AFError>) in
            self.chats = response.value!
            self.tableView.reloadData()
        }
    }

}
