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
import Kingfisher


//-------------------------------------------------------------------------------------------------------------------------------------------------
class FriendsList1Cell: UITableViewCell {
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labeluserid: UILabel!
    @IBOutlet weak var buttonMore: UIButton!
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func bindData(index: Int, friend: Player) {

        imageUser.loadPic(friend.picture)
        labelName.text = friend.name
        labeluserid.text = friend.email
    }
}
