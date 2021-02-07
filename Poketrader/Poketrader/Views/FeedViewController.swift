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
    
    private var controller: FeedController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //remove a borda em baixo do navigation
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        //ate aqui
        self.feedTableView.backgroundColor = UIColor(rgb: 0x355774)
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self

        self.showLoading()
        self.setup()
    }
    
    func setup() {
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
        self.feedTableView.register(UINib(nibName: "OfertaCell", bundle: nil), forCellReuseIdentifier: "OfertaCell")
        self.controller = FeedController()
        self.loadOffers()
    }
    
    func loadOffers() {
        self.controller.loadOfertas { (result, erro) in
            if  result != nil {
                DispatchQueue.main.async {
                    self.feedTableView.delegate = self
                    self.feedTableView.dataSource = self
                    self.feedTableView.reloadData()
                    self.hiddenLoading()
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
                    let ofer: OfertaElement = (self.controller?.getOferta(at: selectedIndexPath.row))!
                    vc.controller = AnuncioController()
                    vc.controller?.insereOferta(oferta: ofer)
                }
            }
        }
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "FeedVC.AnuncioVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OfertaCell? = tableView.dequeueReusableCell(withIdentifier: "OfertaCell", for: indexPath) as? OfertaCell
        cell?.setup(oferta: self.controller?.getOferta(at: indexPath.row))
        return cell ?? UITableViewCell()
    }
}
