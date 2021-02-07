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
        
        // Observe access token changes
        // This will trigger after successfully login / logout
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            // Print out access token
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
            self.dismiss(animated: true, completion: nil)
        }
        
        loadData()
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
