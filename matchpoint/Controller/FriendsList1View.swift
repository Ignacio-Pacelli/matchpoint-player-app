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

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

//-------------------------------------------------------------------------------------------------------------------------------------------------
class FriendsList1View: UIViewController {

    var friends: [Friend] = []
    var selectedRow : Int = 0
    
    
      @IBOutlet weak var tableView: UITableView!
      @IBOutlet weak var searchBar: UISearchBar!
    
      private var followers: [[String: String]] = []
      private var indexPaths: Set<IndexPath> = []

    //---------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {

        super.viewDidLoad()
        title = "Amigos"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never

        //tableView.register(UINib(nibName: "FriendsList1Cell", bundle: Bundle.main), forCellReuseIdentifier: "FriendsList1Cell")

        fetchFriends()
    }
    
    // MARK: - Data methods
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func fetchFriends() {
        AF.request(BASE_URL+FRIENDS_URL).responseDecodable { (response: DataResponse<[Friend], AFError>) in
            self.friends = response.value!
            self.tableView.reloadData()
        }
    }
    

    // MARK: - User actions
    //---------------------------------------------------------------------------------------------------------------------------------------------

    @objc func actionMore(_ sender: UIButton) {

        print(#function)
    }

    // MARK: - Refresh methods
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func refreshTableView() {

        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension FriendsList1View: UITableViewDataSource {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return friends.count
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsList1Cell", for: indexPath) as! FriendsList1Cell
        cell.bindData(index: indexPath.row, friend: self.friends[indexPath.row])
        cell.buttonMore.addTarget(self, action: #selector(actionMore(_:)), for: .touchUpInside)
        return cell
    }
}

// MARK: - UITableViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension FriendsList1View: UITableViewDelegate {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("didSelectItemAt \(indexPath.row)")
        self.selectedRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 70
    }
}
