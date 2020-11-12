//
//  AnuncioViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 10/11/20.
//

import UIKit

class AnuncioViewController: UIViewController {
    private var controller: AnuncioController?
    
    // Imagens
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
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
        
    }
    
}
