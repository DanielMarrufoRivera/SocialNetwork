import UIKit
import LocalAuthentication
import CoreLocation
import UIKit
import KVNProgress
import Material
import TTTAttributedLabel
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import AuthenticationServices

class HomeViewController: UIViewController {
    
    var categories = ["Personas que quizás conozcas", "Reproducir videos", "Publicaciones recientes"]
    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    // MARK: - Properties
    
    
    var cancelRequest: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cancelRequest = false
        
        if NetworkCheck.isConnectedToNetwork() {
            print("You have internet connection!")
        } else {
            print("No internet connection!")
            connectionAlert()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.reloadData()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cancelRequest = true
    }
    
}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! PersonsRow
            cellToReturn = cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NowPlayingRow
            cellToReturn = cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "publicationCell") as! PublicationRow
            cellToReturn = cell
        }
        
        return cellToReturn
    }
    

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0.1538375616, green: 0.1488625407, blue: 0.1489177942, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont(name: "Mosk Normal 400", size: 14)
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return categories[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 90
        }else if indexPath.section == 2{
            return 260
        }
        return 145
    }

}


