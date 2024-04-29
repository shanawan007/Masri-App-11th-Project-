//
//  LoadingViewController.swift
//  Masri App
//
//  Created by Temp on 01/04/2024.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var imageCover: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCover.image = UIImage(named: "BackgroundImage")

    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showInitialView()
        }
        
    }

    private func showInitialView(){
        let isLoggedIn = UserDefaults.standard.string(forKey: "userEmail") != nil
                   && UserDefaults.standard.string(forKey: "userPassword") != nil

        if isLoggedIn{
            let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
            
            let sceneDelegate = view.window?.windowScene?.delegate as! SceneDelegate
            
            let window = sceneDelegate.window
            window?.rootViewController = storyboard
        }
        else{
            performSegue(withIdentifier: "onLoginSignUp", sender: nil)
        }
    }
}
