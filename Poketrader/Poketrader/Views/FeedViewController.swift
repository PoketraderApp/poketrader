//
//  FeedViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 13/11/20.
//

import UIKit


class FeedViewController: BaseViewController {

 
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var feedTableView: UITableView!
    
    @IBOutlet weak var logoff: UIBarButtonItem!
    
    private var controller: FeedController?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
        
        self.showLoading()
        
        self.setup()
        
        self.hiddenLoading()

        // Do any additional setup after loading the view.
    }
    
    func setup() {
        self.feedTableView.register(UINib(nibName: "OfertaCell", bundle: nil), forCellReuseIdentifier: "OfertaCell")
        
        self.controller = FeedController()
        
        self.controller?.loadOfertas { (result, erro) in
            if result {
                DispatchQueue.main.async {
                    self.feedTableView.delegate = self
                    self.feedTableView.dataSource = self
                    self.feedTableView.reloadData()
                }
            } else {
                print("deu ruim")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FeedVC.AnuncioVC" {
            if let vc = segue.destination as? AnuncioViewController {
                if let selectedIndexPath = self.feedTableView.indexPathForSelectedRow {
                    let posicao = selectedIndexPath.row
                    let ofertaID = self.controller?.getOfertaID(at: posicao) ?? 0
                    
                    var ofer: OfertaElement = (self.controller?.getOferta(at: selectedIndexPath.row))!
                    
                    vc.controller = AnuncioController()
                    
                    vc.controller?.insereOferta(oferta: ofer) //setID(id: ofertaID)
                }
            }
        }
    }
    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller?.numberOfRows ?? 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if self.delegate != nil {
////            let pokemonName = self.controller?.getNomePokemon(at: indexPath.row)?.lowercased()
//            self.delegate?.sendOferToAnuncioVC(ofer: (self.controller?.getOferta(at: indexPath.row))!)
////            dismiss(animated: true, completion: nil)
//        }
        self.performSegue(withIdentifier: "FeedVC.AnuncioVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OfertaCell", for: indexPath) as? OfertaCell {
            
            cell.setup(oferta: self.controller?.getOferta(at: indexPath.row))
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}
