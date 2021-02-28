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
import FBSDKLoginKit
import Alamofire
import Foundation
//-------------------------------------------------------------------------------------------------------------------------------------------------
class LoginViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var loginButtonView: UIView!
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {

        super.viewDidLoad()

        let loginButton = FBLoginButton()
        loginButton.center = loginButtonView.center
        view.addSubview(loginButton)
        
        self.loadData()
        
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            if(AccessToken.current?.tokenString != nil){
                let fbToken = AccessToken.current!.tokenString
                self.getJwtToken(fbToken: fbToken)
            }
            else{
                let defaults = UserDefaults.standard
                defaults.setValue(nil, forKey: "facebookToken")
                defaults.setValue(nil, forKey: "jwtToken")
                defaults.setValue(nil, forKey: "playerId")
                defaults.setValue("LOGGED_OUT", forKey: "loginState")
                defaults.synchronize()
            }
        }
    }

    func getJwtToken(fbToken : String){
    
        let url : String = BASE_URL+FACEBOOK_LOGIN_URL
        print("FACEBOOK TOKEN: " + fbToken)
        let parameters: Parameters = ["authToken": fbToken]
        Alamofire.AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable { (response: DataResponse<FacebookLoginResponse, AFError>) in
            
             print("JWT TOKEN: " + response.value!.token)

            let defaults = UserDefaults.standard
            defaults.setValue(fbToken, forKey: "facebookToken")
            defaults.setValue(response.value?.token, forKey: "jwtToken")
            defaults.setValue(response.value?.player.id, forKey: "playerId")
            defaults.setValue("LOGGED_IN", forKey: "loginState")
            defaults.synchronize()
            
            self.dismiss(animated: true) {
            }
        }
    }

    
    // MARK: - Data methods
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func loadData() {

        imageViewLogo.image = UIImage(systemName: "circle.grid.hexagon.fill")
        labelTitle.text = "Bienvenido a MatchPoint"
        labelSubtitle.text = "Reserva una pista en tus clubes favoritos ahora!"
    }

    // MARK: - User actions
    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func actionFacebook(_ sender: Any) {

        print(#function)
        dismiss(animated: true)
    }
}
