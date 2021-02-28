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
class ChatsCell: UITableViewCell {

    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var imageLock: UIImageView!
    @IBOutlet var layoutConstraintImageLockWidth: NSLayoutConstraint!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var imageReadStatus: UIImageView!
    @IBOutlet var layoutConstraintImageReadStatusWidth: NSLayoutConstraint!
    @IBOutlet var labelTime: UILabel!
    @IBOutlet var labelUsername: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var viewUnreadCount: UIView!
    @IBOutlet var labelUnreadCount: UILabel!

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func bindData(index: Int, chat: Chat) {

        for player in chat.participants{
            if player.id != Int(self.getUser().playerId!) {
                labelName.text = player.name
            }
        }
        
        imageProfile.loadPic("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")
        labelTime.text = "00:29"
        labelDescription.text = chat.lastMessage?.content
    }
}
