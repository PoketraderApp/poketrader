//
//  AnuncioViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 10/11/20.
//

import UIKit

class AnuncioViewController: BaseViewController {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nomePokemonLabel: UILabel!
    @IBOutlet weak var usuarioLabel: UILabel!
    @IBOutlet weak var usuarioValueLabel: UILabel!
    @IBOutlet weak var telefoneLabel: UILabel!
    @IBOutlet weak var telefoneValueLabel: UILabel!
    @IBOutlet weak var jogoLabel: UILabel!
    @IBOutlet weak var jogoValueLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailValueLabel: UILabel!
    @IBOutlet weak var observacoesLabel: UILabel!
    @IBOutlet weak var observacoesValueLabel: UILabel!
    @IBOutlet weak var atributosLabel: UILabel!
    @IBOutlet weak var atributosStackView: UIStackView!
    @IBOutlet weak var hpValueLabel: UILabel!
    @IBOutlet weak var defesaValueLabel: UILabel!
    @IBOutlet weak var ataqueValueLabel: UILabel!
    @IBOutlet weak var velocidadeValueLabel: UILabel!
    @IBOutlet weak var ataqueSPValueLabel: UILabel!
    @IBOutlet weak var defesaSPValueLabel: UILabel!
    
    var controller: AnuncioController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        self.controller?.loadAnuncio(completion: { (oferta, erro) in
            if let _oferta = oferta {
                DispatchQueue.main.async {
//                    self.profileImage.isHidden = true
                    self.usuarioValueLabel.text = _oferta.nome
                    self.emailValueLabel.text =  _oferta.email
                    self.telefoneValueLabel.text = _oferta.telefone
                    self.jogoValueLabel.text = _oferta.game
                    self.observacoesValueLabel.text = _oferta.observacoes
                    self.nomePokemonLabel.text = _oferta.pokemon?.name
                    let urlText = _oferta.pokemon?.sprite! ?? ""
                    let url = URL(string: urlText)
                    if let _url = url {
                        self.downloadImage(from: _url)
                        self.hiddenLoading()
                    }
                }
            } else {
                print("\(String(describing: erro))")
            }
        })
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.pokemonImage.image = UIImage(data: data)
            }
        }
    }
}
