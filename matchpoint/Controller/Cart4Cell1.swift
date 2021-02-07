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
import CoreData
//-------------------------------------------------------------------------------------------------------------------------------------------------
class Cart4Cell1: UITableViewCell {

	@IBOutlet var imageProduct: UIImageView!

	@IBOutlet var labelTitle: UILabel!

	@IBOutlet var labelColor: UILabel!
	@IBOutlet var labelQuantity: UILabel!
	@IBOutlet var labelSize: UILabel!

	@IBOutlet var labelPrice: UILabel!
	@IBOutlet var labelOriginalPrice: UILabel!

	@IBOutlet var buttonFavorite: UIButton!
	@IBOutlet var buttonDelete: UIButton!
    
    var bookingVC : Cart4View?
    var startDate : Date?
    var endDate : Date?
    var maxEndDate : Date?

    @IBAction func addHourClicked() {
        
        let startHour = Calendar.current.component(.hour, from: self.startDate!)
        let maxEndHour = Calendar.current.component(.hour, from: self.maxEndDate!)
        let endHour = Calendar.current.component(.hour, from: self.endDate!)

        if(maxEndHour == endHour){
            return
        }
        self.endDate = Calendar.current.date(byAdding: .hour, value: 1, to: self.endDate!)
        self.bookingVC!.endBooking = self.endDate!
        self.bookingVC?.tableView.reloadData()
        self.bookingVC?.reloadPrice()
        
    }
    
    @IBAction func lessHourClicked() {
        if(self.startDate == Calendar.current.date(byAdding: .hour, value: -1, to: self.endDate!)){
            return
        }
        self.endDate = Calendar.current.date(byAdding: .hour, value: -1, to: self.endDate!)
        self.bookingVC!.endBooking = self.endDate!
        self.bookingVC?.tableView.reloadData()
        self.bookingVC?.reloadPrice()
    }
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
	override func awakeFromNib() {

		super.awakeFromNib()

		buttonFavorite.layer.borderWidth = 1
        buttonFavorite.layer.borderColor = AppColor.Border?.cgColor

		buttonDelete.layer.borderWidth = 1
        buttonDelete.layer.borderColor = AppColor.Border?.cgColor
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func bindData(index: IndexPath, data: [String: String]) {

		guard let title = data["title"] else { return }
		guard let price = data["price"] else { return }
		guard let originalPrice = data["originalPrice"] else { return }
		guard let color = data["color"] else { return }
		guard let quantity = data["quantity"] else { return }
		guard let size = data["size"] else { return }

		imageProduct.sample("Ecommerce", "Shoes", index.row+15)
		labelTitle.text = title
		labelPrice.text = price
//		labelOriginalPrice.text = originalPrice
//		labelOriginalPrice.isHidden = (originalPrice == "")
		labelColor.text = "Color: " + color
//		labelSize.text = "Size: " + size
//		labelQuantity.text = "QTY: " + quantity
	}
    
    func bindClub(club: Club, court: Court) {
        imageProduct.loadPic(club.picture)
        labelTitle.text = club.name
        labelColor.text = court.name
        labelPrice.text = ""
        buttonFavorite.isHidden = true
        buttonDelete.isHidden = true
    }
    
    func bindLocation(location: Location) {
//        imageProduct.loadPic("https://toppng.com/uploads/preview/office-locations-office-location-icon-11562974310f7mvv1cta6.png")
        labelTitle.text = location.address
        labelColor.text = location.city + ", " + location.postal_code
        labelPrice.text = location.country
        buttonFavorite.isHidden = true
        buttonDelete.isHidden = true
    }
    
    func bindStartDate(date: Date, endDate: Date, bookingVC : Cart4View, maxEndDate: Date) {

        self.bookingVC = bookingVC
        self.startDate = date
        self.endDate = endDate
        self.maxEndDate = maxEndDate
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let day = formatter.string(from: date)
        labelTitle.text = day
        
        formatter.dateFormat = "HH:mm"
        let startHour = "Desde: " + formatter.string(from: date)
        labelColor.text = startHour
            
        formatter.dateFormat = "HH:mm"
        let endHour = "Hasta: " + formatter.string(from: endDate)
        labelPrice.text = endHour
        
    }
    
}
