//
//  SplashViewController.swift
//  Poketrader
//
//  Created by André Lucas on 30/01/21.
//

import UIKit
import FirebaseAuth

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "LoginVC.FeedVC", sender: nil)
                
            }
        } else {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "LoginViewController", sender: nil)
                
            }
        }
    }
    
    
}
