//
//  EsqueciSenhaVC.swift
//  Poketrader
//
//  Created by Rodolpho on 08/12/20.
//

import UIKit

class EsqueciSenhaViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetarSenhaButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resetarSenhaButton.layer.cornerRadius = 4
        resetarSenhaButton.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetarSenhaButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Esqueci a senha", message: "Feito! Foi enviado a você um email com instruções para resetar sua senha!", preferredStyle: .alert)
        
        let botao = UIAlertAction(title: "Fechar", style: .default, handler: nil)
        
        alert.addAction(botao)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
