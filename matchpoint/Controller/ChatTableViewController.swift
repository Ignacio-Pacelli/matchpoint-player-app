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
class ChatTableViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!

    var chats: [Chat] = []
    var selectedRow : Int = 0

    //---------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {

        super.viewDidLoad()
        title = "Chats"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(actionAdd(_:)))

//        tableView.register(UINib(nibName: "ChatsCell", bundle: Bundle.main), forCellReuseIdentifier: "ChatsCell")

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchChats()
    }
    // MARK: - Data methods
    //---------------------------------------------------------------------------------------------------------------------------------------------
    
    func fetchChats() {

        let url : String = BASE_URL+CHAT_URL
        debugPrint(url)
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let authHeaders = HTTPHeader.authorization(bearerToken: self.view.getUser().jwtToken!)

        AF.request(url, headers: [authHeaders]).responseJSON { response in
            if let data = response.data {
                self.chats = try! decoder.decode(Array<Chat>.self, from: data)
                self.tableView.reloadData()
            }
        }
    }
    
    

    // MARK: - User actions
    //---------------------------------------------------------------------------------------------------------------------------------------------
    @objc func actionEdit(_ sender: UIButton) {

        print(#function)
        dismiss(animated: true)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    @objc func actionAdd(_ sender: UIButton) {

        print(#function)
        dismiss(animated: true)
    }

    // MARK: - Refresh methods
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func refreshTableView() {

        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension ChatTableViewController: UITableViewDataSource {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return chats.count
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatsCell", for: indexPath) as! ChatsCell
        cell.bindData(index: indexPath.item, chat: chats[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension ChatTableViewController: UITableViewDelegate {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 90
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "MessagesSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "MessagesSegue":
            let messagesVC = segue.destination as! MatchpointChatViewController
            messagesVC.chat = self.chats[selectedRow]
        default:
            return
        }
    }
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let muteAction = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
            print(#function)
            completionHandler(true)
        }
        muteAction.image = UIImage(systemName: "speaker.slash.fill")
        muteAction.backgroundColor = UIColor.darkGray

        let deleteAction = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
            print(#function)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.backgroundColor = UIColor.systemGray

        return UISwipeActionsConfiguration(actions: [deleteAction, muteAction])
    }
}
