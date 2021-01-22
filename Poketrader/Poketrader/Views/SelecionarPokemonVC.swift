//
//  SelecionarPokemonVC.swift
//  Poketrader
//
//  Created by Gabriel Duarte on 19/01/21.
//

import UIKit

protocol SelecionarPokemonVCDelegate {
    func sendDataToCadastroVC(nomePokemon: String)
}

class SelecionarPokemonVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var controller: SelecionarPokemonController?
    
    var delegate: SelecionarPokemonVCDelegate? = nil
    var isLoading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "ListaDePokemonCell", bundle: nil), forCellReuseIdentifier: "ListaDePokemonCell")
        
        self.controller = SelecionarPokemonController()
        self.controller?.getTwentyPokemons(){ (result, error) in
            if result {
                //self.controller?.teste()
                DispatchQueue.main.async {
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                }
            }
            else{
                print("Deu ruim")
            }
        }
        

    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height

            if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
                loadMoreData()
            }
    }
    
    func loadMoreData() {
        if self.controller?.numberOfRows ?? 0 < self.controller?.numberOfPokemonsInDatabase ?? 0 {
        if !self.isLoading {
          self.isLoading = true
          DispatchQueue.global().async {
            // Fake background loading task for 2 seconds
            sleep(2)
            self.controller?.getTwentyPokemons(url: self.controller?.nextURL()){ (result, error) in
                
            }
            DispatchQueue.main.async {
              self.tableView.reloadData()
              self.isLoading = false
            }
          }
        }
      } else {
        isLoading = false
      }
    }
    
}


extension SelecionarPokemonVC: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller?.numberOfRows ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListaDePokemonCell", for: indexPath) as? ListaDePokemonCell {
            cell.setup(nomePokemon: self.controller?.getNomePokemon(at: indexPath.row))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.delegate != nil {
            let pokemonName = self.controller?.getNomePokemon(at: indexPath.row)?.lowercased()
            self.delegate?.sendDataToCadastroVC(nomePokemon: pokemonName ?? "")
            dismiss(animated: true, completion: nil)
        }
    }
    

}
