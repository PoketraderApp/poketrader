//
//  ViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 01/11/20.
//

import UIKit

class OfertasUsuario: UIViewController {

    @IBOutlet weak var botaoAdicionarOferta: UIButton!
    @IBOutlet weak var tableViewOfertas: UITableView!
    
    let pkmn = ["Charmander", "Squirtle", "Dragonair"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableViewOfertas.register(UINib(nibName: "OfertaCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableViewOfertas.delegate = self
        self.tableViewOfertas.dataSource = self
    }
}

//MARK: TableView delegate & data source
extension OfertasUsuario: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pkmn.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? OfertaCell {
            cell.nomePkmn.text = self.pkmn[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    
}

