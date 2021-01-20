//
//  SelecionarPokemonVC.swift
//  Poketrader
//
//  Created by Gabriel Duarte on 19/01/21.
//

import UIKit

class SelecionarPokemonVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "OfertaCell", bundle: nil), forCellReuseIdentifier: "OfertaCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    

    

}

extension SelecionarPokemonVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
