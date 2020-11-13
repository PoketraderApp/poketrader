//
//  ViewController.swift
//  Poketrader
//
//  Created by Augusto Rocha on 12/11/20.
//

import UIKit

class OfertasUsuario: UIViewController {

    @IBOutlet weak var botaoAdicionarOferta: UIButton!
    @IBOutlet weak var tableViewOfertas: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedAddPokemon(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueAddPokemon", sender: nil)
    }
}
