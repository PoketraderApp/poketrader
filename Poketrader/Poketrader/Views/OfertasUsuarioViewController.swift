//
//  OfertasUsuarioViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 01/11/20.
//

import UIKit
import Firebase
import FirebaseFirestore

class Oferta: Codable {
    var url: String?
    var game: String?

}

class OfertasUsuarioViewController: UIViewController {

    @IBOutlet weak var botaoAdicionarOferta: UIButton!
    @IBOutlet weak var tableViewOfertas: UITableView!
    
    let pkmn_name = ["Charmander Nº004", "Squirtle Nº007", "Dragonair Nº148"]
    let pkmn_game = ["Pokemon Blue", "Pokemon Blue", "Pokemon Blue"]
    let pkmn_img  = ["4", "7", "148"]
    let jogadorNome = "Player 1"
    
    var controller: MeuAnuncioController?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableViewOfertas.register(UINib(nibName: "OfertaCell", bundle: nil), forCellReuseIdentifier: "OfertaCell")
        self.tableViewOfertas.delegate = self
        self.tableViewOfertas.dataSource = self
        
        
        self.controller = MeuAnuncioController()
        
        self.controller?.loadOfertas { (result, erro) in
            if result {
                DispatchQueue.main.async {
                    self.tableViewOfertas.delegate = self
                    self.tableViewOfertas.dataSource = self
                    self.tableViewOfertas.reloadData()
                }
            } else {
                print("deu ruim")
            }
        }
        
        
    }
    @IBAction func tappedAddButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "MinhasOfertasVC.CadastrarVC", sender: self)
    }
}

//MARK: TableView delegate & data source
extension OfertasUsuarioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.pkmn_name.count
        
        return self.controller?.numberOfRows ?? 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "MinhasOfertasVC.MeuAnuncioVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OfertaCell", for: indexPath) as? OfertaCell {
            
            cell.setup(oferta: self.controller?.getOferta(at: indexPath.row))
            
            
//            cell.nomePkmn.text = self.pkmn_name[indexPath.row]
//            cell.tituloJogo.text = self.pkmn_game[indexPath.row]
//            cell.nomeJogador.text = jogadorNome
//            
//            cell.imagemPkmn.image = UIImage(named: self.pkmn_img[indexPath.row])
            
            return cell
        }
        return UITableViewCell()
    }
}

