//
//  FeedViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 13/11/20.
//

import UIKit

class FeedViewController: UIViewController {

 
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var feedTableView: UITableView!
    
    @IBOutlet weak var logoff: UIBarButtonItem!
    let pkmn_name = ["Charmander Nº004", "Squirtle Nº007"]
    let pkmn_game = ["Pokemon Blue", "Pokemon Blue"]
    let pkmn_img  = ["4", "7"]
    let jogadorNome = "Player 1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
        
        self.feedTableView.register(UINib(nibName: "OfertaCell", bundle: nil), forCellReuseIdentifier: "OfertaCell")

        // Do any additional setup after loading the view.
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pkmn_name.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "FeedVC.AnuncioVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OfertaCell", for: indexPath) as? OfertaCell {
            cell.nomePkmn.text = self.pkmn_name[indexPath.row]
            cell.tituloJogo.text = self.pkmn_game[indexPath.row]
            cell.nomeJogador.text = jogadorNome
            
            cell.imagemPkmn.image = UIImage(named: self.pkmn_img[indexPath.row])
            
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}
