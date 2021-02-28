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
class SuccessView: UIViewController {

    @IBOutlet var labelDescription: UILabel!
    @IBOutlet weak var successImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var booking : Booking?
    var club : Club?
    var court : Court?

    //---------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {

        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        
        self.titleLabel.text = "Reserva confirmada!"
        
        
        self.fetchClub()
    }
    
    func fillMessage(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let start = dateFormatter.string(from: (self.booking?.startDate!)!)
        let end = dateFormatter.string(from: (self.booking?.endDate!)!)

        var message : String = "Reserva en club " + self.club!.name
        message = message + " empieza a las " + start
        message = message + " y acaba a las " + end
        
        self.labelDescription.text = message
    }

    func fetchClub() {
        
        let authHeaders = HTTPHeader.authorization(bearerToken: self.view.getUser().jwtToken!)

        AF.request(BASE_URL+CLUB_URL+String(self.booking!.club_id), headers: [authHeaders]).responseDecodable { (response: DataResponse<Club, AFError>) in
            self.club = response.value!
            self.fetchCourt()
        }
    }
    
    func fetchCourt() {
        debugPrint(#function)
        
        let url : String = BASE_URL+CLUB_URL+String(self.booking!.club_id)+COURT_URL+String(self.booking!.court_id)
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let authHeaders = HTTPHeader.authorization(bearerToken: self.view.getUser().jwtToken!)

        AF.request(url, headers: [authHeaders]).responseJSON { response in
            if let data = response.data {
                self.court = try! decoder.decode(Court.self, from: data)
                self.fillMessage()
            }
        }
    }
    
    // MARK: - User actions
    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func actionSave(_ sender: UIButton) {

        print(#function)
        dismiss(animated: true, completion: nil)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func actionLearnMore(_ sender: UIButton) {

        print(#function)
        dismiss(animated: true, completion: nil)
    }
}
