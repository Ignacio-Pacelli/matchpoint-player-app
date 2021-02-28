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
import Kingfisher
import Alamofire
//-------------------------------------------------------------------------------------------------------------------------------------------------
class Tours1Cell: UITableViewCell {

	@IBOutlet var imageViewTour: UIImageView!
	@IBOutlet var labelRatings: UILabel!
	@IBOutlet var buttonLikeDislike: UIButton!
	@IBOutlet var labelTourName: UILabel!
	@IBOutlet var labelPlacesCount: UILabel!
	@IBOutlet var labelDays: UILabel!
	@IBOutlet var labelAmount: UILabel!
    
    var club: Club!
    var isFav: Bool = false
    var tourVC: Tours1View?
	//---------------------------------------------------------------------------------------------------------------------------------------------
    func bindData(index: Int, club: Club, favorites: [Club], tourVC: Tours1View) {
        self.tourVC = tourVC
        self.club = club
        imageViewTour.loadPic(club.picture)
		labelRatings.text = "9.0"
		labelTourName.text = club.name
		labelPlacesCount.text = "5 pistas"
		labelDays.text = "Lunes a Domingo"
		labelAmount.text = "desde 5€/h"
        
        self.isFav = false
        buttonLikeDislike.tintColor = .lightGray
        
        if(favorites.count>0){
            for favClub in favorites {
                if(favClub.id == club.id){
                    self.isFav = true
                    buttonLikeDislike.tintColor = .systemRed
                    break
                }
            }
        }
	}

	// MARK: - User actions
	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionLikeDislike(_ sender: Any) {
        let url : String = BASE_URL+FAVORITES_URL+String(self.club.id)
        let authHeaders = HTTPHeader.authorization(bearerToken: self.getUser().jwtToken!)
        
        if(self.isFav){
            AF.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: [authHeaders]).responseJSON { response in
                print("delete" + String(self.club.id))
                self.tourVC?.fetchFavClubs()
            }
        }
        else{
            AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: [authHeaders]).responseJSON { response in
                print("post" + String(self.club.id))
                self.tourVC?.fetchFavClubs()
            }
        }
    }
}
