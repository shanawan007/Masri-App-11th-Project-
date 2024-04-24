//
//  FacialViewController.swiftThirdViewController
//  Masri App
//
//  Created by Temp on 26/03/2024.
//

import UIKit

class FacialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var table: UITableView!
    
    var imagesOnDisplay = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingImage()
        table.dataSource = self
        table.delegate = self
        
        table.register(UINib(nibName: "FacialTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.table.backgroundColor = UIColor.black
    }
    
    func fetchingImage(){
        imagesOnDisplay = ["facialImage1","facialImage2","facialImage3","facialImage4","facialImage5","facialImage6","facialImage7"]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesOnDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FacialTableViewCell
        cell.displayImage.image = UIImage(named: imagesOnDisplay[indexPath.row])
        
        cell.contentView.layer.cornerRadius = 12
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }

}
