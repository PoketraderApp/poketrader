//
//  AnuncioViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 10/11/20.
//

import UIKit

class AnuncioViewController: BaseViewController {
    
    
    var controller: AnuncioController?
        
    // Imagens
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    // Campo do Pokémon
    @IBOutlet weak var nomePokemonLabel: UILabel!
    
    // Campo do usuário
    @IBOutlet weak var usuarioLabel: UILabel!
    @IBOutlet weak var usuarioValueLabel: UILabel!
    
    // Campo do telefone
    @IBOutlet weak var telefoneLabel: UILabel!
    @IBOutlet weak var telefoneValueLabel: UILabel!
    
    // Campo do jogo
    @IBOutlet weak var jogoLabel: UILabel!
    @IBOutlet weak var jogoValueLabel: UILabel!
    
    // Campo de email
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailValueLabel: UILabel!
    
    // Campo de observações
    @IBOutlet weak var observacoesLabel: UILabel!
    @IBOutlet weak var observacoesValueLabel: UILabel!
    
    // Campo de atributos
    @IBOutlet weak var atributosLabel: UILabel!
    @IBOutlet weak var atributosStackView: UIStackView!
    
    @IBOutlet weak var hpValueLabel: UILabel!
    @IBOutlet weak var defesaValueLabel: UILabel!
    @IBOutlet weak var ataqueValueLabel: UILabel!
    @IBOutlet weak var velocidadeValueLabel: UILabel!
    @IBOutlet weak var ataqueSPValueLabel: UILabel!
    @IBOutlet weak var defesaSPValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showLoading()
        
//        self.controller = AnuncioController()
        
        self.controller?.loadAnuncio(completion: { (oferta, erro) in
            if let _oferta = oferta {
                DispatchQueue.main.async {
                    self.profileImage.isHidden = true
                    
                    self.usuarioValueLabel.text = oferta?.nome  //self.controller?.nomeUsuario
                    self.emailValueLabel.text =  oferta?.email //self.controller?.emailUsuario
                    self.telefoneValueLabel.text = oferta?.telefone //self.controller?.telefoneUsuario
                    self.jogoValueLabel.text = oferta?.game
                    self.observacoesValueLabel.text = oferta?.observacoes //self.controller?.observacoes
                    
                    self.nomePokemonLabel.text = oferta?.pokemon?.name //self.controller?.pokemonName
                    
                    // se nÃo achar imagem, bota a imagem 3 como default
//                    self.pokemonImage.image = UIImage(named: self.controller?.imageID ?? "3")
                    let urlText = oferta?.pokemon?.sprite! ?? ""
                    let url = URL(string: urlText)
                    if let _url = url {
                        self.downloadImage(from: _url)
                        self.hiddenLoading()
                    }
                    
                    
                    
                    
                    
                }
            } else {
                print("\(erro)")
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
