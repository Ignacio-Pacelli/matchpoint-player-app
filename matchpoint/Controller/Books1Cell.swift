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
class Books1Cell: UITableViewCell {

    @IBOutlet weak var imageBookCover: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelOwner: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelRating: UILabel!


    func bindData(index: Int, booking: Booking) {

        
        /*
        guard let name = data["name"] else { return }
        guard let author = data["author"] else { return }
        guard let date = data["date"] else { return }
        guard let rating = data["rating"] else { return }
        guard let review = data["review"] else { return }
         */
       
//        imageBookCover.loadPic(clubs.picture)
        labelName.text = "Padel Cubierto"
        labelOwner.text = "Matias Pacelli"
        labelDate.text = "03-02-2021"
        labelRating.text = String(booking.price) + " €/hora"
    }
}
