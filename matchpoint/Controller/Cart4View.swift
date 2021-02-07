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
class Cart4View: UIViewController {


    
    
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet var tableView: UITableView!
	@IBOutlet var layoutConstraintTableViewHeight: NSLayoutConstraint!
	@IBOutlet var labelSubTotal: UILabel!

    @IBAction func dismissButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    private var products: [[String: String]] = []
    var playerId : Int?
    var club : Club?
    var court: Court?
    var startBooking : Date?
    var endBooking : Date?
    var totalPrice : Double?
    var reservationsVC : ReservationViewController?
    
	override func viewDidLoad() {

		super.viewDidLoad()
        viewTitle.text = "Reservar Pista"
        reloadPrice()
	}
    
    @IBAction func bookButtonClicked() {
    
        //player id, club_id, court_id
        //start_date, end_date, price
        let url : String = BASE_URL+PLAYER_URL+"1"+CLUB_URL+String(self.club!.id)+COURT_URL+String(self.court!.id)+BOOKING_URL
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let start = dateFormatter.string(from: self.startBooking!)
        let end = dateFormatter.string(from: self.endBooking!)

        
        let parameters: Parameters = ["startDate": start, "endDate": end, "price": self.totalPrice]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            self.dismiss(animated: true) {
                print("TODO OK!")
                self.reservationsVC!.fetchBookings()
            }
        }
    }

    
    func reloadPrice() {
        
        let startHour = Calendar.current.component(.hour, from: self.startBooking!)
        let endHour = Calendar.current.component(.hour, from: self.endBooking!)

        let sum = Double(endHour - startHour) * self.court!.pricePerHour
        self.totalPrice = sum
        
        self.labelSubTotal.text = String(sum) + "€"
    }


	// MARK: - Refresh methods
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func refreshTableView() {

		tableView.reloadData()
	}

	// MARK: - User actions
	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionCancel(_ sender: UIButton) {

		print(#function)
		dismiss(animated: true)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionClearAll(_ sender: UIButton) {

		print(#function)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionCheckout(_ sender: UIButton) {

		print(#function)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionFavorite(_ sender: UIButton) {

		print(#function)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionDelete(_ sender: UIButton) {

		print(#function)
	}
}

// MARK: - UITableViewDataSource
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension Cart4View: UITableViewDataSource {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func numberOfSections(in tableView: UITableView) -> Int {

		return 1
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		layoutConstraintTableViewHeight.constant = CGFloat(80*3)
		return 3
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "Cart4Cell1", for: indexPath) as! Cart4Cell1
        
        switch indexPath.row {
        case 0:
            cell.bindClub(club: self.club!, court: self.court!)
        case 1:
            cell.bindLocation(location: self.club!.location)
        case 2:
            cell.bindStartDate(date: self.startBooking!, endDate: self.endBooking!, bookingVC: self, maxEndDate: self.court!.closingTime!)
        default:
            cell.bindData(index: indexPath, data: products[indexPath.row])
            cell.buttonFavorite.addTarget(self, action: #selector(actionFavorite(_:)), for: .touchUpInside)
            cell.buttonDelete.addTarget(self, action: #selector(actionDelete(_:)), for: .touchUpInside)
        }

		return cell
	}
}

// MARK: - UITableViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension Cart4View: UITableViewDelegate {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

		return 80
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		print(#function)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
