//
//  ViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 01/11/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func botaoLoginScreen(_ sender: UIButton) {
        performSegue(withIdentifier: "LoginScreen", sender: nil)
    }
    
}

