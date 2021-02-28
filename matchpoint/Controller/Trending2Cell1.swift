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
class Trending2Cell1: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var labelType: UILabel!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelSongs: UILabel!
    @IBOutlet var buttonPlay: UIButton!

    //---------------------------------------------------------------------------------------------------------------------------------------------
//    func bindData(index: Int, data: [String: Any]) {
//
//        guard let type = data["type"] as? String else { return }
//        guard let title = data["title"] as? String else { return }
//        guard let songs = data["songs"] as? String else { return }
//
//        imageView.sample("Media", "Music", index)
//        labelType.text = type
//        labelTitle.text = title
//        labelSongs.text = songs
//    }
    
//    func bindClub(index: Int, club: Club) {
//
//        imageView.loadPic(club.picture)
//        labelType.text = club.location.city
//        labelTitle.text = club.name
//        labelSongs.text = club.location.country
//    }
    func bindNews(news: News){
        imageView.loadPic(news.pictureUrl!)
        labelType.text = news.club.name
        labelTitle.text = news.title
        labelSongs.text = news.subtitle
    }

    // MARK: - User actions
    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func actionPlay(_ sender: Any) {

        print(#function)
    }
}
