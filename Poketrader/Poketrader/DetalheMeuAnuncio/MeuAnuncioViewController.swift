//
//  MeuAnuncioViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 12/11/20.
//

import UIKit

class MeuAnuncioViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func pressedEditarButton(_ sender: UIButton) {
    }
    
    @IBAction func pressedExcluirButton(_ sender: UIButton) {
    }
}
