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
import SwiftyJSON

//-------------------------------------------------------------------------------------------------------------------------------------------------
class Tours1View: UIViewController {

    var clubs: [Club] = []
    var favClubs: [Club] = []
    var selectedRow : Int = 0

    @IBOutlet weak var tableView: UITableView!

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Clubs"

        fetchClubs()
        fetchFavClubs()
	}

	// MARK: - Data methods
	//---------------------------------------------------------------------------------------------------------------------------------------------
    
    func fetchClubs() {
        clubs.removeAll()
        let authHeaders = HTTPHeader.authorization(bearerToken: self.view.getUser().jwtToken!)

        AF.request(BASE_URL+CLUB_URL, headers: [authHeaders]).responseDecodable { (response: DataResponse<[Club], AFError>) in
            self.clubs = response.value!
            self.tableView.reloadData()
        }
    }
    
    func fetchFavClubs() {
        favClubs.removeAll()
        let authHeaders = HTTPHeader.authorization(bearerToken: self.view.getUser().jwtToken!)

        AF.request(BASE_URL+FAVORITES_URL, headers: [authHeaders]).responseDecodable { (response: DataResponse<[Club], AFError>) in
            self.favClubs = response.value!
            self.tableView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "ClubDetailSegue":
            let courtsTVC = segue.destination as! TourView
            courtsTVC.club = self.clubs[selectedRow]
        default:
            return
        }
    }

	// MARK: - User actions
	//---------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionWishlist() {

		print(#function)
	}
}

// MARK: - UITableViewDataSource
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension Tours1View: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return clubs.count
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

		return view.frame.size.height / 4.2
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "Tours1Cell", for: indexPath) as! Tours1Cell
        cell.bindData(index: indexPath.row, club: self.clubs[indexPath.row], favorites: self.favClubs, tourVC: self)
		return cell
	}
    
    
}

// MARK: - UITableViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension Tours1View: UITableViewDelegate {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		print("didSelectItemAt \(indexPath.row)")
        self.selectedRow = indexPath.row
		tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ClubDetailSegue", sender: nil)
	}
}
