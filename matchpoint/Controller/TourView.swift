//
// Copyright (c) 2020 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import Alamofire

//-------------------------------------------------------------------------------------------------------------------------------------------------
class TourView: UIViewController {
    
    @IBOutlet var imageViewTour: UIImageView!
    @IBOutlet var labelTourName: UILabel!
    @IBOutlet var labelDays: UILabel!
    @IBOutlet var labelAmount: UILabel!
    @IBOutlet var buttonLikeDislike: UIButton!
    
    @IBOutlet var labelRatings: UILabel!
    @IBOutlet var labelReviews: UILabel!
    
    @IBOutlet var tableView1: UITableView!
    @IBOutlet var constraintTableView1Height: NSLayoutConstraint!
    
    @IBOutlet var tableView2: UITableView!
    @IBOutlet var constraintTableView2Height: NSLayoutConstraint!
    
    private var navigationBackgroundImage: UIImage?
    
    var club : Club?
    var courts: [Court] = []
    var selectedRow : Int = 0
   

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        title = club!.name
        navigationBackgroundImage = navigationController?.navigationBar.backgroundImage(for: .default)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        imageViewTour.loadPic(club!.picture)
        labelTourName.text = club!.name
        labelDays.text = "Lunes a Domingo"
        labelAmount.text = "desde 5€/h"
        labelRatings.text = "7.5"
        labelReviews.text = "78 reviews"
        
        tableView1.tableFooterView = UIView()
        
        fetchCourts()
    }
    
    func fetchCourts() {
        debugPrint(#function)
        
        let clubId : String = String(club!.id)
        let url : String = BASE_URL+CLUB_URL+clubId+COURT_URL
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let authHeaders = HTTPHeader.authorization(bearerToken: self.view.getUser().jwtToken!)

        AF.request(url, headers: [authHeaders]).responseJSON { response in
            if let data = response.data {
                self.courts = try! decoder.decode(Array<Court>.self, from: data)
                self.tableView2.reloadData()
                self.tableView2.performBatchUpdates(nil, completion: { (result) in
                    self.constraintTableView1Height.constant = self.tableView1.contentSize.height - 1
                    self.constraintTableView2Height.constant = self.tableView2.contentSize.height
                })
            }
        }
        
        
//        AF.request(url).responseDecodable { (response: DataResponse<[Court], AFError>) in
//            self.courts = response.value!
//            self.tableView2.reloadData {
//                self.constraintTableView1Height.constant = self.tableView1.contentSize.height - 1
//                self.constraintTableView2Height.constant = self.tableView2.contentSize.height
//            }
//        }
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(navigationBackgroundImage, for: .default)
    }

    
    @IBAction func actionLikeDislike(_ sender: Any) {
        
        print(#function)
    }
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func actionReviews(_ sender: Any) {
        
        print(#function)
    }
    
}

extension TourView: UITableViewDataSource {
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tableView1 { return 2 }
        if tableView == tableView2 { return courts.count }
        
        return 0
    }
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("pinto celda")
        if tableView == tableView1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TourCell1", for: indexPath) as! TourCell1
            switch indexPath.row {
            case 0:
                cell.bindInfo(title: "Teléfono", subtitle: club!.phone_number)
            case 1:
                cell.bindInfo(title: club!.location.city, subtitle: club!.location.address)
            default:
                return cell
            }
            return cell
        }
        if tableView == tableView2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TourCell2", for: indexPath) as! TourCell2
            cell.bindCourt(court: courts[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}


extension TourView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("didSelectItemAt \(indexPath.row)")
        self.selectedRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "CalendarSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "CalendarSegue":
            let reservationVC = segue.destination as! ReservationViewController
            reservationVC.club = self.club
            reservationVC.court = self.courts[selectedRow]
        default:
            return
        }
    }
}


