//
//  OfertaCell.swift
//  Poketrader
//
//  Created by David Souza on 11/11/2020.
//

import UIKit
import Firebase

class OfertaCell: UITableViewCell {

    @IBOutlet weak var imagemPkmn: UIImageView!
    @IBOutlet weak var nomePkmn: UILabel!
    @IBOutlet weak var tituloJogo: UILabel!
    @IBOutlet weak var nomeJogador: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
                self?.imagemPkmn.image = UIImage(data: data)
            }
        }
    }
    
    func setup(oferta: OfertaElement?) {
        if let oferta = oferta {
            self.nomePkmn.text = oferta.pokemon?.name
            self.tituloJogo.text = "JOGO XPTO"
            self.nomeJogador.text = oferta.nome
            
            let urlText = oferta.pokemon?.sprite! ?? ""
            
            let url = URL(string: urlText)
            if let _url = url {
                downloadImage(from: _url)
            }
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
