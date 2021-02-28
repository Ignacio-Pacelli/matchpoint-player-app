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
import FBSDKLoginKit

//-------------------------------------------------------------------------------------------------------------------------------------------------
class HomeViewController: UIViewController {
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    @IBOutlet weak var constraintCollectionView3Height: NSLayoutConstraint!
    

    private var navigationBackgroundImage: UIImage?
    private var collections: [[String: String]] = []
    private var albums: [[String: String]] = []
    private var genres = ["Pop", "Classical", "Rock", "Blues", "Jazz", "Dance"]

    var clubs: [Club] = []
    var news: [News] = []
    var friends: [Player] = []
    var selectedRow : Int = 0
    var selectedChat : Chat?

    //---------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if(false){
            LoginManager().logOut()
            let defaults = UserDefaults.standard
            defaults.setValue(nil, forKey: "facebookToken")
            defaults.setValue(nil, forKey: "jwtToken")
            defaults.setValue(nil, forKey: "playerId")
            defaults.setValue("LOGGED_OUT", forKey: "loginState")
            defaults.synchronize()
        }
        
        
//        user = MatchpointUser(facebookToken: nil, jwtToken: nil, loginState: LoginState.LOGGED_OUT)

        self.title = "Matchpoint"
//        navigationBackgroundImage = navigationController?.navigationBar.backgroundImage(for: .default)
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = AppColor.Theme

    }
    
    func loadData(user : MatchpointUser) {
        fetchClubs(user: user)
        fetchFriends(user: user)
        fetchNews(user: user)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let defaults = UserDefaults.standard

        let user : MatchpointUser = MatchpointUser(facebookToken: defaults.string(forKey: "facebookToken"), jwtToken: defaults.string(forKey: "jwtToken"), loginState: defaults.string(forKey: "loginState"), playerId: defaults.string(forKey: "playerId"))
        
        if(user.loginState == "LOGGED_OUT" || user.loginState == nil){
            performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
        else{
            self.loadData(user: user)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "NewsSegue":
            let newsVC = segue.destination as! Article1View
            newsVC.news = self.news[selectedRow]
        case "FriendChatSegue":
            let chatVC = segue.destination as! MatchpointChatViewController
            chatVC.chat = self.selectedChat
        case "ClubSegue":
            let clubVC = segue.destination as! TourView
            clubVC.club = self.clubs[selectedRow]
        default:
            return
        }
    }
    
    
    func fetchNews(user : MatchpointUser) {
        let url : String = BASE_URL+NEWS_URL
        let authHeaders = HTTPHeader.authorization(bearerToken: user.jwtToken!)

        AF.request(url, headers: [authHeaders]).responseDecodable { (response: DataResponse<[News], AFError>) in
            self.news = response.value!
            self.collectionView1.reloadData()
            self.pageControl.numberOfPages = self.news.count
            //self.collectionView3.reloadData()
        }
    }
    
    func fetchClubs(user : MatchpointUser) {
        print("fetchClubs")

        let authHeaders = HTTPHeader.authorization(bearerToken: user.jwtToken!)
        
        AF.request(BASE_URL+CLUB_URL, headers:[authHeaders]).responseDecodable { (response: DataResponse<[Club], AFError>) in
            self.clubs = response.value!
            //self.collectionView1.reloadData()
            //self.pageControl.numberOfPages = self.clubs.count
            self.collectionView3.reloadData()
        }
    }
    
    func fetchFriends(user : MatchpointUser) {
        let authHeaders = HTTPHeader.authorization(bearerToken: user.jwtToken!)

        AF.request(BASE_URL+FRIENDS_URL, headers: [authHeaders]).responseDecodable { (response: DataResponse<[Player], AFError>) in
            self.friends = response.value!
            self.collectionView2.reloadData()
        }
    }
    

    //---------------------------------------------------------------------------------------------------------------------------------------------
    
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
//        constraintCollectionView3Height.constant = collectionView3.contentSize.height
        constraintCollectionView3Height.constant = 150

    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    override func viewWillDisappear(_ animated: Bool) {

        navigationController?.navigationBar.setBackgroundImage(navigationBackgroundImage, for: .default)
    }

    @IBAction func actionSeeAllAlbums(_ sender: Any) {

        print(#function)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func actionSeeAllGenres(_ sender: Any) {

        print(#function)
    }

}


extension HomeViewController: UICollectionViewDataSource {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if (collectionView == collectionView1) { return news.count }
        if (collectionView == collectionView2) { return friends.count }
        if (collectionView == collectionView3) { return clubs.count }

        return 0
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if (collectionView == collectionView1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Trending2Cell1", for: indexPath) as! Trending2Cell1
            cell.bindNews(news: self.news[indexPath.row])
           // cell.bindData(index: indexPath.item, data: collections[indexPath.row])
            return cell
        }
        if (collectionView == collectionView2) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Trending2Cell2", for: indexPath) as! Trending2Cell2
            cell.bindFriends(index: indexPath.row, friend: self.friends[indexPath.row])
            //cell.bindData(index: indexPath.item, data: albums[indexPath.row])
            return cell
        }
        if (collectionView == collectionView3) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Trending2Cell3", for: indexPath) as! Trending2Cell3
            cell.bindClub(club: self.clubs[indexPath.row])
            //cell.bindData(title: genres[indexPath.row])
            return cell
        }

        return UICollectionViewCell()
    }
}
// MARK:- UICollectionViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension HomeViewController: UICollectionViewDelegate {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("didSelectItemAt \(indexPath.row)")
        self.selectedRow=indexPath.row
        if (collectionView == collectionView1) {
            self.performSegue(withIdentifier: "NewsSegue", sender: nil)
        }
        if (collectionView == collectionView2) {
            self.goToChat(forFriend: self.friends[indexPath.row])
        }
        if (collectionView == collectionView3) {
            self.performSegue(withIdentifier: "ClubSegue", sender: nil)
        }
    }
    
    func goToChat(forFriend friend : Player) {

        let url : String = BASE_URL+FRIENDS_URL+String(friend.id)+CHAT_URL
        debugPrint(url)
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let authHeaders = HTTPHeader.authorization(bearerToken: self.view.getUser().jwtToken!)

        AF.request(url, headers: [authHeaders]).responseJSON { response in
            if let data = response.data {
                
                let chat = try! decoder.decode(Chat.self, from: data)
                self.selectedChat = chat
                self.performSegue(withIdentifier: "FriendChatSegue", sender: nil)
            }
        }
    }
    
    
//---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if collectionView == collectionView1 {
            pageControl.currentPage = indexPath.row
        }
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension HomeViewController: UICollectionViewDelegateFlowLayout {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let screenRect: CGRect = UIScreen.main.bounds
        let screenWidth: CGFloat = screenRect.size.width
        let height = collectionView.frame.size.height

        if collectionView == collectionView1 {
            return CGSize(width: screenWidth, height: height)
        }
        if collectionView == collectionView2 {
            return CGSize(width: (screenWidth - 40)/2.3, height: height)
        }
        if collectionView == collectionView3 {
            return CGSize(width: (screenWidth - 40)/2, height: 44)
        }
        return CGSize(width: 0, height: 0)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        if collectionView == collectionView1 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        if collectionView == collectionView2 {
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
        if collectionView == collectionView3 {
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        if collectionView == collectionView1 {
            return 0
        }
        if collectionView == collectionView2 {
            return 10
        }
        if collectionView == collectionView3 {
            return 10
        }
        return 0
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        if collectionView == collectionView1 {
            return 0
        }
        if collectionView == collectionView2 {
            return 10
        }
        if collectionView == collectionView3 {
            return 10
        }
        return 0
    }
}
