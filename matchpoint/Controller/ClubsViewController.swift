//
//  ClubsViewController.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 25/1/21.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class ClubsTableViewController: UITableViewController {
    
    var clubs: [Club] = []
    var selectedRow : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Clubs"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemBlue
        
        fetchClubs()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.clubs[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
        selectedRow = indexPath.row
        self.performSegue(withIdentifier: "CourtSegue", sender: self.clubs[indexPath.row])
    }
    
    func fetchClubs() {
        AF.request(BASE_URL+CLUB_URL).responseDecodable { (response: DataResponse<[Club], AFError>) in
            self.clubs = response.value!
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "CourtSegue":
            let courtsVC = segue.destination as! TourView
            courtsVC.club = self.clubs[selectedRow]
        default:
            return
        }
}

}
