//
//  AnuncioViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 10/11/20.
//

import UIKit

class AnuncioViewController: UIViewController {
    var controller: AnuncioController? = AnuncioController()
        
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
        
        controller?.loadAnuncio(completion: { (carregou, erro) in
            if carregou {
                DispatchQueue.main.async {
                    self.profileImage.isHidden = true
                    
                    self.usuarioValueLabel.text = self.controller?.nomeUsuario
                    self.emailValueLabel.text = self.controller?.emailUsuario
                    self.telefoneValueLabel.text = self.controller?.telefoneUsuario
                    self.observacoesValueLabel.text = self.controller?.observacoes
                    
                    self.nomePokemonLabel.text = self.controller?.pokemonName
                    
                    // se nÃo achar imagem, bota a imagem 3 como default
                    self.pokemonImage.image = UIImage(named: self.controller?.imageID ?? "3")
                    
                    
                }
            }
        })
        
        
        
    }
    
}
