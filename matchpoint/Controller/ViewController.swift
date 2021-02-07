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
class ViewController: UIViewController {
    
    
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
    var friends: [Friend] = []
    var selectedRow : Int = 0
    //---------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {

        super.viewDidLoad()

        self.title = "Matchpoint"
        navigationBackgroundImage = navigationController?.navigationBar.backgroundImage(for: .default)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        //collectionView1.register(UINib(nibName: "Trending2Cell1", bundle: nil), forCellWithReuseIdentifier: "Trending2Cell1")
        //collectionView2.register(UINib(nibName: "Trending2Cell2", bundle: nil), forCellWithReuseIdentifier: "Trending2Cell2")
        //collectionView3.register(UINib(nibName: "Trending2Cell3", bundle: nil), forCellWithReuseIdentifier: "Trending2Cell3")

        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = AppColor.Theme

        //loadData()
        fetchClubs()
        fetchFriends()
        
    }
    
    func fetchClubs() {
        AF.request(BASE_URL+CLUB_URL).responseDecodable { (response: DataResponse<[Club], AFError>) in
            self.clubs = response.value!
            self.collectionView1.reloadData()
            self.pageControl.numberOfPages = self.clubs.count
            self.collectionView3.reloadData()
        }
    }
    
    func fetchFriends() {
        AF.request(BASE_URL+FRIENDS_URL).responseDecodable { (response: DataResponse<[Friend], AFError>) in
            self.friends = response.value!
            self.collectionView2.reloadData()
        }
    }
    

    //---------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLayoutSubviews() {

        constraintCollectionView3Height.constant = collectionView3.contentSize.height
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


extension ViewController: UICollectionViewDataSource {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if (collectionView == collectionView1) { return clubs.count }
        if (collectionView == collectionView2) { return friends.count }
        if (collectionView == collectionView3) { return clubs.count }

        return 0
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if (collectionView == collectionView1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Trending2Cell1", for: indexPath) as! Trending2Cell1
            cell.bindClub(index: indexPath.row, club: self.clubs[indexPath.row])
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
            cell.bindClub(index: indexPath.row, club: self.clubs[indexPath.row])
            //cell.bindData(title: genres[indexPath.row])
            return cell
        }

        return UICollectionViewCell()
    }
}

// MARK:- UICollectionViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension ViewController: UICollectionViewDelegate {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("didSelectItemAt \(indexPath.row)")

        if (collectionView == collectionView1) {
        }
        if (collectionView == collectionView2) {
        }
        if (collectionView == collectionView3) {
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
extension ViewController: UICollectionViewDelegateFlowLayout {

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

//
//  ViewController.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 25/1/21.
//




/*

import UIKit
import SideMenu

class ViewController: UIViewController {
    
    var menu: SideMenuNavigationController?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        menu = SideMenuNavigationController(rootViewController: ViewController())
//        menu?.leftSide = true
//        menu?.setNavigationBarHidden(true, animated: true)
//        menu?.menuWidth = view.bounds.width * 0.7
//        menu?.statusBarEndAlpha = 0
//        
//        
//        SideMenuManager.default.leftMenuNavigationController = menu
//        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
//        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)
//      
//        
        //self.performSegue(withIdentifier: "LoginSegue", sender: self)
        
        
    }
    //Button
    @IBAction func didTapMenu(_ sender: Any) {
        present(menu!, animated: true)
        
    }
    
    @IBAction func showClubsScreen(_ sender: Any) {
        print("showClubsScreen")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(true){
            

        }
    }
 
}

*/
