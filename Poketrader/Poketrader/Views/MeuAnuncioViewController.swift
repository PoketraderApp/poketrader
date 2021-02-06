//
//  MeuAnuncioViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 12/11/20.
//

import UIKit

class MeuAnuncioViewController: BaseViewController {
    
    // Imagens
    @IBOutlet weak var pokemonImage: UIImageView!
    
    // Campo do Pokémon
    @IBOutlet weak var nomePokemonLabel: UILabel!
    
    // Campo do usuário
    @IBOutlet weak var usuarioValueLabel: UILabel!
    
    // Campo do telefone
    @IBOutlet weak var telefoneValueLabel: UILabel!
    
    // Campo do jogo
    @IBOutlet weak var jogoValueLabel: UILabel!
    
    // Campo de email
    @IBOutlet weak var emailValueLabel: UILabel!
    
    // Campo de observações
    @IBOutlet weak var observacoesValueLabel: UILabel!
    
    
    @IBOutlet weak var hpValueLabel: UILabel!
    @IBOutlet weak var defesaValueLabel: UILabel!
    @IBOutlet weak var ataqueValueLabel: UILabel!
    @IBOutlet weak var velocidadeValueLabel: UILabel!
    @IBOutlet weak var ataqueSPValueLabel: UILabel!
    @IBOutlet weak var defesaSPValueLabel: UILabel!
    
    private var oferta: OfertaElement?
    
    var controller: MeuAnuncioController?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entrou editar")
        self.showLoading()
        
        self.controller?.loadAnuncio(completion: { (oferta, erro) in
            if let _oferta = oferta {
                self.oferta = _oferta
                DispatchQueue.main.async {
//                    self.profileImage.isHidden = true
                    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MeuAnuncioVC.EditarVC" {
            if let vc = segue.destination as? EdicaoPokemonViewController {
                
                
                vc.controller = OfertasUsuarioController()
                
                vc.controller?.setOferta(ofer: self.oferta ?? OfertaElement())
                
//                vc.controller?.
//                if let selectedIndexPath = self.feedTableView.indexPathForSelectedRow {
//                    let posicao = selectedIndexPath.row
//                    let ofertaID = self.controller?.getOfertaID(at: posicao) ?? 0
//
//                    var ofer: OfertaElement = (self.controller?.getOferta(at: selectedIndexPath.row))!
//
//                    vc.controller = AnuncioController()
//
//                    vc.controller?.insereOferta(oferta: ofer) //setID(id: ofertaID)
//                }
            }
        }
    }
    
    @IBAction func pressedEditarButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "MeuAnuncioVC.EditarVC", sender: self)
    }
    
    @IBAction func pressedExcluirButton(_ sender: UIButton) {
    }
}
