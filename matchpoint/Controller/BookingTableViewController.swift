//
//  BookingTableViewController.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 27/1/21.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class BookingTableViewCell: UITableViewCell {

    @IBOutlet weak var clubName: UILabel!
}

class BookingTableViewController: UITableViewController {
  
    var bookings: [Booking] = []
    var selectedRow : Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mis Reservas"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemBlue
        
        fetchMyBookings()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookingTableViewCell
        
//        cell.clubName?.text = String(self.bookings[indexPath.row].owner.name)
//       cell.ownerName?.text = self.players[indexPath.row].name
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("selected index %d", indexPath.row)
        selectedRow = indexPath.row

        //self.performSegue(withIdentifier: "BookingSegue", sender: self)
    }
    
    
    func fetchMyBookings() {
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        //BASE_URL/players/1/bookings
        let url : String = BASE_URL+PLAYER_URL+"1"+BOOKING_URL
        debugPrint(url)
        
        AF.request(url, headers: nil).responseJSON { response in
            if let data = response.data {
                self.bookings = try! decoder.decode(Array<Booking>.self, from: data)
                self.tableView.reloadData()
            }
        }
    }
}
