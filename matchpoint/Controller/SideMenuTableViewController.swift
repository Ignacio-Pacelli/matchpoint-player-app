//
//  SideMenuTableViewController.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 19/2/21.
//

import Foundation
import UIKit

class SideMenuTableViewController: UITableViewController {
    
    @IBOutlet var tableViewSide: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("quien es ese hombre?")
        
        self.tableViewSide.backgroundColor = .white
        self.tableViewSide.borderColor = .systemGray5
        //Profile Image
        profileImage.layer.borderWidth = 1.0
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100
        default:
            return 80
        }
    }
    
}
    
