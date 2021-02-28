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

    var friends: [Player] = []
    var selectedRow : Int = 0
    var selectedChat : Chat?

    
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
        let authHeaders = HTTPHeader.authorization(bearerToken: self.view.getUser().jwtToken!)
        AF.request(BASE_URL+FRIENDS_URL, headers: [authHeaders]).responseDecodable { (response: DataResponse<[Player], AFError>) in
            self.friends = response.value!
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "ChatSegueFromFriends":
            let chatVC = segue.destination as! MatchpointChatViewController
            chatVC.chat = self.selectedChat
        default:
            return
        }
    }
    // MARK: - User actions
    //---------------------------------------------------------------------------------------------------------------------------------------------

    @objc func actionMore(_ sender: UIButton) {
        
        self.goToChat(forFriend: self.friends[sender.tag])
    }

    func goToChat(forFriend friend : Player) {

        let url : String = BASE_URL+CHAT_URL
        debugPrint(url)
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let authHeaders = HTTPHeader.authorization(bearerToken: self.view.getUser().jwtToken!)

        AF.request(url, headers: [authHeaders]).responseJSON { response in
            if let data = response.data {
                
                let chats = try! decoder.decode(Array<Chat>.self, from: data)
                for chat in chats {
                    for player in chat.participants {
                        if player.id == friend.id {
                            self.selectedChat = chat
                            self.performSegue(withIdentifier: "ChatSegueFromFriends", sender: nil)
                        }
                    }
                }
            }
        }
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
