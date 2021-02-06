//
//  TelaInicialViewController.swift
//  Poketrader
//
//  Created by Gabriel Duarte on 10/11/20.
//

import UIKit

class TelaInicialViewController: UIViewController {
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var imageTelaInicial: UIImageView!
    @IBOutlet weak var cadastroButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cadastroButton.backgroundColor = UIColor(rgb: 0xB3A125)
        self.imageTelaInicial.image = UIImage(named: "telaInicialPokeTrader")
        self.imageTelaInicial.layer.cornerRadius = 100
    }
    
    @IBAction func tappedCadastro(_ sender: UIButton) {
        self.performSegue(withIdentifier: "InicioVC.CadastroVC", sender: nil)
    }

    @IBAction func tappedEntrar(_ sender: UIButton) {
        self.performSegue(withIdentifier: "InicioVC.LoginVC", sender: nil)
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
