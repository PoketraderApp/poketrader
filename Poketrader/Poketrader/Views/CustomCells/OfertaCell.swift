//
//  OfertaCell.swift
//  Poketrader
//
//  Created by David Souza on 11/11/2020.
//

import UIKit

class OfertaCell: UITableViewCell {

    @IBOutlet weak var imagemPkmn: UIImageView!
    @IBOutlet weak var nomePkmn: UILabel!
    @IBOutlet weak var tituloJogo: UILabel!
    @IBOutlet weak var nomeJogador: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(oferta: OfertaElement?) {
        if let oferta = oferta {
            self.nomePkmn.text = oferta.pokemon?.name
            self.tituloJogo.text = "JOGO XPTO"
            self.nomeJogador.text = oferta.nome
            self.imagemPkmn.image = UIImage(named: String(oferta.pokemon?.id ?? 3))
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
