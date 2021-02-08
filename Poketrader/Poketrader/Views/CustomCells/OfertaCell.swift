//
//  OfertaCell.swift
//  Poketrader
//
//  Created by David Souza on 11/11/2020.
//

import UIKit
import Firebase

protocol OfertaCellDelegate: class {
    func addOffer()
}

class OfertaCell: UITableViewCell {
    
    weak var delegate: OfertaCellDelegate?

    @IBOutlet weak var imagemPkmn: UIImageView!
    @IBOutlet weak var nomePkmn: UILabel!
    @IBOutlet weak var tituloJogo: UILabel!
    @IBOutlet weak var nomeJogador: UILabel!
    @IBOutlet weak var pokebola: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var subContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.imagemPkmn.image = UIImage(data: data)
            }
        }
    }
    
    func setup(oferta: OfertaElement?) {
        if let oferta = oferta {
            self.nomePkmn.text = oferta.pokemon?.name
            self.tituloJogo.text = "Jogo: \(String(describing: oferta.game!))"
            self.nomeJogador.text = "Nv: \(String(describing: oferta.nv!))"
            self.container.layer.cornerRadius = 7
            self.container.backgroundColor = UIColor(rgb: 0x3B6978)
            self.subContainer.backgroundColor = UIColor(rgb: 0x3B6978)
            
            self.pokebola.image = self.pokebola.image?.withRenderingMode(.alwaysTemplate)
            self.pokebola.tintColor = UIColor(rgb: 0x193342)
            
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
    
// estou sobrescrevendo o metodo e colocando espaçamento entre as celulas
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 0 , right: 10))
        
    }
    
}
