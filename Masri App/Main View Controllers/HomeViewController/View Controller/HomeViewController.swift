import UIKit
import SideMenu
import Alamofire
import AlamofireImage


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SideMenuNavigationControllerDelegate {
    
    var promotions: [Promotions] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableOfPromotion.dataSource = self
        tableOfPromotion.delegate = self
        
        tableOfPromotion.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableOfPromotion.backgroundColor = UIColor.black
        sideButtonLable.setTitle("", for: .normal)
        sideButtonLable.setImage(UIImage(named: "menuImage"), for: .normal)
        
        self.navigationController?.navigationBar.isHidden = true
        appointmentLable.layer.cornerRadius = 5
        bookAppointmentLable.layer.cornerRadius = 5
        fetchData()
    }
    
    @IBOutlet weak var tableOfPromotion: UITableView!
    
    @IBOutlet weak var sideButtonLable: UIButton!
    
    @IBAction func appointmentHistory(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Appointments", bundle: nil)
        let shareVC = storyboard.instantiateViewController(withIdentifier: "AppointmentViewController") as! AppointmentViewController
        shareVC.modalPresentationStyle = .fullScreen
        self.present(shareVC, animated: true)
    }
    
    @IBOutlet weak var appointmentLable: UIButton!
    
    @IBAction func appointmentBook(_ sender: Any) {
        
    let urlOpen = URL(string: "https://healow.com/apps/provider/haitham-masri-3324")
    UIApplication.shared.open(urlOpen!, options: [:])
    }
    
    @IBOutlet weak var bookAppointmentLable: UIButton!
    
    func fetchData() {
        PromotionApiManager.shareInstance.callingPromotionAPI(completionHandler: {
            (response) in
            if let imageURLFound = response{
                self.promotions = response ?? []
                
                DispatchQueue.main.async{
                    self.tableOfPromotion.reloadData()
                }
            } else {
                    print("No")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promotions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableOfPromotion.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeViewCell
        let mainURL = "https://masriapi.ssasoft.com/"
        if let promotion = promotions[indexPath.row] as? Promotions{
            let url = URL(string: mainURL + promotion.image )
            
        
            
            cell.picturesOnDisplay.af.setImage(withURL: url!)
        }
        cell.contentView.layer.cornerRadius = 12
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
        
    }
}
