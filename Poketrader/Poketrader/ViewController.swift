//
//  ViewController.swift
//  Poketrader
//
//  Created by Augusto Rocha on 12/11/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedAddPokemon(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueAddPokemon", sender: nil)
    }
}
