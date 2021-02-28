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
class Books1View: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!

    var bookings: [Booking] = []
    var selectedRow : Int = 0

    override func viewDidLoad() {

        super.viewDidLoad()
        title = "Mis Reservas"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never

//        let buttonMenu = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(actionMenu(_:)))
//        navigationItem.rightBarButtonItem = buttonMenu

        updateUI()
        fetchMyBookings()
    }
    
    func fetchMyBookings() {
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        //BASE_URL/bookings
        let url : String = BASE_URL+BOOKING_URL
        debugPrint(url)
        let authHeaders = HTTPHeader.authorization(bearerToken: self.view.getUser().jwtToken!)

        AF.request(url, headers: [authHeaders]).responseJSON { response in
            if let data = response.data {
                self.bookings = try! decoder.decode(Array<Booking>.self, from: data)
                self.tableView.reloadData()
            }
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)
        updateUI()
    }

    func updateUI() {

        let background = UIColor.systemBackground.image(segmentedControl.frame.size)
        let selected = AppColor.Theme.image(segmentedControl.frame.size)

        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : AppColor.Theme], for: .normal)
        segmentedControl.setBackgroundImage(background, for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(selected, for: .selected, barMetrics: .default)
        segmentedControl.setDividerImage(UIColor.systemBackground.image(), forLeftSegmentState: .normal, rightSegmentState: [.normal, .highlighted, .selected], barMetrics: .default)
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = AppColor.Theme.cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "SuccessSegue":
            let bookingSuccessVC = segue.destination as! SuccessView
            bookingSuccessVC.booking = self.bookings[self.selectedRow]
        default:
            return
        }
    }
    

    // MARK: - User actions
    //---------------------------------------------------------------------------------------------------------------------------------------------
    @objc func actionMenu(_ sender: UIButton) {

        print(#function)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func actionSegmentChange(_ sender: UISegmentedControl) {

        print(#function)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    @objc func actionAdd(_ sender: UIButton) {

        print(#function)
        sender.isSelected = !sender.isSelected
    }
}

// MARK: - UITableViewDataSource
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension Books1View: UITableViewDataSource {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return bookings.count
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Books1Cell", for: indexPath) as! Books1Cell
        cell.bindData(index: indexPath.row, booking: self.bookings[indexPath.row])
        //cell.bindData(index: indexPath.item, data: books[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension Books1View: UITableViewDelegate {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 120
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.selectedRow = indexPath.row
        self.performSegue(withIdentifier: "SuccessSegue", sender: self)
    }
}


// MARK: - UIColor
//-------------------------------------------------------------------------------------------------------------------------------------------------
fileprivate extension UIColor {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {

        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
