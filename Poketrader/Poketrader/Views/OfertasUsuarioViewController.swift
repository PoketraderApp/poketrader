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

class OfertasUsuarioViewController: BaseViewController {

    @IBOutlet weak var botaoAdicionarOferta: UIButton!
    @IBOutlet weak var tableViewOfertas: UITableView!
    
    var controller: OfertasUsuarioController?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        
        // Do any additional setup after loading the view.
        self.tableViewOfertas.register(UINib(nibName: "OfertaCell", bundle: nil), forCellReuseIdentifier: "OfertaCell")
        self.tableViewOfertas.delegate = self
        self.tableViewOfertas.dataSource = self
        
        
        self.controller = OfertasUsuarioController()
        
        self.controller?.loadOfertas { (result, erro) in
            if result {
                DispatchQueue.main.async {
                    self.tableViewOfertas.delegate = self
                    self.tableViewOfertas.dataSource = self
                    self.tableViewOfertas.reloadData()
                    self.hiddenLoading()
                }
            } else {
                print("deu ruim")
            }
        }
        
        
    }
    
    @IBAction func tappedAddButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "MinhasOfertasVC.CadastrarVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MinhasOfertasVC.MeuAnuncioVC" {
            if let vc = segue.destination as? MeuAnuncioViewController {
                if let selectedIndexPath = self.tableViewOfertas.indexPathForSelectedRow {
//                    let posicao = selectedIndexPath.row
//                    let ofertaID = self.controller?.getOfertaID(at: posicao) ?? 0
                    
                    let ofer: OfertaElement = (self.controller?.getOferta(at: selectedIndexPath.row))!
                    
                    vc.controller = MeuAnuncioController()
                    
                    vc.controller?.insereOferta(oferta: ofer) //setID(id: ofertaID)
                }
            }
        }
    }
}

//MARK: TableView delegate & data source
extension OfertasUsuarioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller?.numberOfRows ?? 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "MinhasOfertasVC.MeuAnuncioVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OfertaCell", for: indexPath) as? OfertaCell {
            
            cell.setup(oferta: self.controller?.getOferta(at: indexPath.row))
            
            return cell
        }
        return UITableViewCell()
    }
}

