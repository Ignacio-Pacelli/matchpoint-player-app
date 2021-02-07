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
    var selectedRow : Int = 0

    @IBOutlet weak var tableView: UITableView!

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Clubs"

		navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill"), style: .done, target: self, action: #selector(actionProfile)), UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .done, target: self, action: #selector(actionWishlist))]

//		tableView.register(UINib(nibName: "Tours1Cell", bundle: nil), forCellReuseIdentifier: "Tours1Cell")

        fetchClubs()
	}

	// MARK: - Data methods
	//---------------------------------------------------------------------------------------------------------------------------------------------
    
    func fetchClubs() {
        AF.request(BASE_URL+CLUB_URL).responseDecodable { (response: DataResponse<[Club], AFError>) in
            self.clubs = response.value!
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

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionProfile() {

		print(#function)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionSortBy(_ sender: Any) {

		print(#function)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionFilters(_ sender: Any) {

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
        cell.bindData(index: indexPath.row, club: self.clubs[indexPath.row])
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


