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
class ProfileViewController: UIViewController {

    @IBOutlet var imageViewProfile: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var labelWeightLoss: UILabel!
    @IBOutlet var labelAerobics: UILabel!
    @IBOutlet var labelSlimming: UILabel!
    @IBOutlet var labelZumba: UILabel!
    @IBOutlet var collectionView: UICollectionView!

    
    var clubs: [Club] = []
    var selectedRow : Int = 0

    //---------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {

        super.viewDidLoad()
//        navigationController?.navigationBar.prefersLargeTitles = false
//        navigationItem.largeTitleDisplayMode = .never
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonFollow)

        //collectionView.register(UINib(nibName: "Profile2Cell", bundle: Bundle.main), forCellWithReuseIdentifier: "Profile2Cell")
        loadData()
        fetchClubs()
    }
    func fetchClubs() {
        let authHeaders = HTTPHeader.authorization(bearerToken: self.view.getUser().jwtToken!)
        
        AF.request(BASE_URL+CLUB_URL, headers: [authHeaders]).responseDecodable { (response: DataResponse<[Club], AFError>) in
            self.clubs = response.value!
            self.collectionView.reloadData()
        }
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
//    override func viewWillAppear(_ animated: Bool) {
//
//        super.viewWillAppear(animated)
//        if let navController = navigationController as? NavigationController {
//            navController.setBackground(color: .clear)
//        }
//    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
//    override func viewWillDisappear(_ animated: Bool) {
//
//        super.viewWillDisappear(animated)
//        if let navController = navigationController as? NavigationController {
//            navController.setNavigationBar()
//        }
//    }

    // MARK: - Data methods
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func loadData() {

        imageViewProfile.loadPic("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")
        labelTitle.text = "Nacho Pacelli"
        labelDescription.text = "Mi nombre es Nacho, vivo en Berlin y soy un amante del padel desde hace más de 10 años"
        labelWeightLoss.text = "Nivel: 4,5"
        labelAerobics.text = "Posición: Reves"
        labelSlimming.text = "Mano Hábil: Diestra"
        labelZumba.text = "Punto fuerte: Pegada"
    }

    // MARK: - Refresh methods
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func refreshCollectionView() {

        collectionView.reloadData()
    }

    // MARK: - User actions
    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func actionFollow(_ sender: UIButton) {

        print(#function)
        dismiss(animated: true)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func actionSeeAll(_ sender: UIButton) {

        print(#function)
        dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDataSources
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension ProfileViewController: UICollectionViewDataSource {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return clubs.count
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Profile2Cell", for: indexPath) as! Profile2Cell
        cell.bindClub(index: indexPath.row, club: self.clubs[indexPath.row])
        //cell.bindData(index: indexPath, data: tranings[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension ProfileViewController: UICollectionViewDelegate {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print(#function)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension ProfileViewController: UICollectionViewDelegateFlowLayout {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.frame.size.width - 40)/2.5
        let height = collectionView.frame.size.height - 20
        return CGSize(width: width, height: height)
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 10
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 10
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
}
