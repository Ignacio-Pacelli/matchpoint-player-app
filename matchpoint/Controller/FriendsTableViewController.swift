//
//  FriendsTableViewController.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 28/1/21.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON


class FriendsTableViewController: UITableViewController {
  
    var friends: [Player] = []
    var club : Club?
    var selectedRow : Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Amigos"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemBlue
        
        fetchFriends()
    }
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.friends[indexPath.row].name
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("selected index %d", indexPath.row)
        selectedRow = indexPath.row

        //self.performSegue(withIdentifier: "BookingSegue", sender: self)
    }
    
    func fetchFriends() {
        AF.request(BASE_URL+FRIENDS_URL).responseDecodable { (response: DataResponse<[Player], AFError>) in
            self.friends = response.value!
            self.tableView.reloadData()
        }
    }
}



