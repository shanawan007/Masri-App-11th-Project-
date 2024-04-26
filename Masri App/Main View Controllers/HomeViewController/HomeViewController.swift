import UIKit
import SideMenu
import Alamofire
import AlamofireImage


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SideMenuNavigationControllerDelegate {
    
    
    
    @IBOutlet weak var tableOfPromotion: UITableView!
    
    @IBOutlet weak var sideButtonLable: UIButton!
    
    
    @IBAction func appointmentHistory(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Appointments", bundle: nil)
        let shareVC = storyboard.instantiateViewController(withIdentifier: "AppointmentViewController") as! AppointmentViewController
        shareVC.modalPresentationStyle = .fullScreen
        self.present(shareVC, animated: true)
        //        self.navigationController?.pushViewController(shareVC, animated: true)
        //
    }
    
    @IBOutlet weak var appointmentLable: UIButton!
    
    
    @IBAction func appointmentBook(_ sender: Any) {
    }
    
    
    @IBOutlet weak var bookAppointmentLable: UIButton!
    
    
    var promotions: [PromotionModel] = []
    
    var promotionImage: [String] = []
    
    
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
    func fetchData() {
        var imageURL:String = "https://masriapi.ssasoft.com/"
        
        PromotionApiManager.shareInstance.callingPromotionAPI(completionHandler: {
            (imageURLComing) in
                if let imageURLFound = imageURLComing{
                    for found in imageURLFound {
                        let fullURL = imageURL + found
                        self.promotionImage.append(fullURL)
                    }
                    DispatchQueue.main.async{
                        self.tableOfPromotion.reloadData()
                    }
                }
            else{
                print("No")
            }
            })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promotionImage.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableOfPromotion.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeViewCell
        
        let promotion = promotionImage[indexPath.row]
        if let url = URL(string: promotion) {
            cell.picturesOnDisplay.af.setImage(withURL: url)
            
        }
        cell.contentView.layer.cornerRadius = 12
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
        
    }
}
