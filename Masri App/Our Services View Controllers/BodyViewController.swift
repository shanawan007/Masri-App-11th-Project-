//
//  BodyViewController.swift
//  Masri App
//
//  Created by Temp on 26/03/2024.
//

import UIKit

class BodyViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var imagesForBodyContainer = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self
        
        table.register(UINib(nibName: "BodyTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        fetchingImage()
        self.table.backgroundColor = UIColor.black
    }
    
    func fetchingImage(){
        imagesForBodyContainer = ["bodyImage1","bodyImage2","bodyImage3","bodyImage4"]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesForBodyContainer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BodyTableViewCell
        cell.bodyContainerImage.image = UIImage(named: imagesForBodyContainer[indexPath.row])
        cell.contentView.layer.cornerRadius = 12
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }

}
