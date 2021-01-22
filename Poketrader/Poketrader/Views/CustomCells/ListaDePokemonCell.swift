//
//  ListaDePokemonCell.swift
//  Poketrader
//
//  Created by Gabriel Duarte on 22/01/21.
//

import UIKit

class ListaDePokemonCell: UITableViewCell {
    
    @IBOutlet weak var nomePkmn: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(nomePokemon: String?){
        
        if let _nomePokemon = nomePokemon {
            self.nomePkmn.text = _nomePokemon
        }
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
