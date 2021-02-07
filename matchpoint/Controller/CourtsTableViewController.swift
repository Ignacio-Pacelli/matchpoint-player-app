//
//  ClubsViewController.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 25/1/21.
//

import Foundation
import UIKit
import Alamofire

class CourtsTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
}


class CourtsTableViewController: UITableViewController {
  
    var courts: [Court] = []
    var club : Club?
    var selectedRow : Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = club?.name
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemBlue
        
        fetchCourts()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourtCell", for: indexPath) as! CourtsTableViewCell
        
        cell.name?.text = self.courts[indexPath.row].name
        cell.price?.text = String(self.courts[indexPath.row].pricePerHour)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("selected index %d", indexPath.row)
        selectedRow = indexPath.row

        //self.performSegue(withIdentifier: "ReservationSegue", sender: self)
    }
    
    func fetchCourts() {
        
        let clubId : String = String(club!.id)
        let url : String = BASE_URL+CLUB_URL+clubId+COURT_URL
        
        AF.request(url).responseDecodable { (response: DataResponse<[Court], AFError>) in
            self.courts = response.value!
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "ReservationSegue":
            let reservationVC = segue.destination as! ReservationViewController
            reservationVC.club = self.club
            reservationVC.court = self.courts[selectedRow]
        default:
            return
        }
}
    
}


