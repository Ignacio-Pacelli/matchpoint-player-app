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

//-------------------------------------------------------------------------------------------------------------------------------------------------
class Article1View: UIViewController {

    @IBOutlet var imageNews: UIImageView!
    @IBOutlet var labelCategory: UILabel!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var imageUser: UIImageView!
    @IBOutlet var labelUsername: UILabel!
    @IBOutlet var labelLocation: UILabel!
    @IBOutlet var labelDescription: UILabel!

    
    var news: News?
    
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {

        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        self.title = "Noticias"

        loadData()
    }

//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    override func viewWillAppear(_ animated: Bool) {
//
//        super.viewWillAppear(animated)
//        if let navController = navigationController as? NavigationController {
//            navController.setBackground(color: .clear)
//        }
//    }
//
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    override func viewWillDisappear(_ animated: Bool) {
//
//        super.viewWillDisappear(animated)
//
//        if let navBar = navigationController as? NavigationController {
//            navBar.setNavigationBar()
//        }
//    }

    // MARK: - Data methods
    //--------------------------------------------------------------------------------------------------------------------------------------------
    func loadData() {

        imageNews.loadPic((news?.pictureUrl)!)
        imageUser.loadPic((news?.club.picture)!)
        labelCategory.text = "PUBLICADA"
        labelDate.text = "Falta lo de la fecha"
        labelTitle.text = news?.title
        labelUsername.text = news?.club.name
        labelLocation.text = "Matchpoint"
        labelDescription.text = news?.content
    }
}

// MARK: - UIScrollViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
//extension Article1View: UIScrollViewDelegate {
//
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        if scrollView.tag == 11 {
//            if let navController = navigationController as? NavigationController {
//                if (scrollView.contentOffset.y > imageNews.frame.size.height/2) {
//                    navController.setBackground(color: .systemBackground)
//                } else {
//                    navController.setBackground(color: .clear)
//                }
//            }
//        }
//    }
//}
