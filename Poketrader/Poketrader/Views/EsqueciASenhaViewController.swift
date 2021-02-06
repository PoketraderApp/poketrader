//
//  EsqueciASenhaViewController.swift
//  Poketrader
//
//  Created by Rodolpho on 10/12/20.
//

import UIKit

class EsqueciASenhaViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetarSenhaButton: UIButton!
    
    private var loginController: LoginController = LoginController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resetarSenhaButton.layer.cornerRadius = 4
        resetarSenhaButton.clipsToBounds = true
//        resetarSenhaButton.backgroundColor = UIColor(rgb: 0xFF453A)
    }
    
    @IBAction func resetarSenhaButton(_ sender: Any) {
        
        if emailTextField.text != "" {
            loginController.forgotPassword(email: emailTextField.text ?? "") { (error) in
                guard let _error = error else {
                
                    let alert = UIAlertController(title: "Esqueci a senha", message: "Feito! Foi enviado a você um email com instruções para resetar sua senha!", preferredStyle: .alert)
                    
                    let botao = UIAlertAction(title: "Fechar", style: .default, handler: { (UIAlertAction) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    
                    alert.addAction(botao)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    return
                }
                
                let alert = UIAlertController(title: "Esqueci a senha", message: _error.localizedDescription, preferredStyle: .alert)
                
                let botao = UIAlertAction(title: "Fechar", style: .default, handler: nil)
                
                alert.addAction(botao)
                
                self.present(alert, animated: true, completion: nil)

                print(_error)
            }
        } else {
            let alert = UIAlertController(title: "Esqueci a senha", message: "Favor preencher o seu email!", preferredStyle: .alert)
            
            let botao = UIAlertAction(title: "Fechar", style: .default, handler: nil)
            
            alert.addAction(botao)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
