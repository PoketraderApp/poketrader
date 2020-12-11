//
//  LoginViewController.swift
//  Poketrader
//
//  Created by Rodolpho on 11/11/20.
//
import UIKit

class LoginViewController: UIViewController { 

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var entrarButton: UIButton!
    
    @IBOutlet weak var backgroudImageLogin: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        entrarButton.layer.cornerRadius = 4
        entrarButton.clipsToBounds = true
        backgroudImageLogin.image = UIImage(named: "imagemLogin")
        // Do any additional setup after loading the view.
    }
    
    private func checkFields() -> Bool {
        
        if self.emailTextField.text?.isEmpty ?? true {
            return false
        } else if self.senhaTextField.text?.isEmpty ?? true {
            return false
        }
        return true
    }
    
    @IBAction func cadastroButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "LoginVC.CadastroVC", sender: nil)
    }
    
    @IBAction func entrarButton(_ sender: UIButton) {
        
       if self.checkFields() {
            LoginController(email: self.emailTextField.text, senha: self.senhaTextField.text).login { (result, error ) in
                
                if result {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "LoginVC.FeedVC", sender: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        let alert =  UIAlertController(title: "Alerta", message: "Usuário ou senha inválidos", preferredStyle: .alert)
                        let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(buttonOk)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
         } else {
            let alert =  UIAlertController(title: "Alerta", message: "Campos obrigatórios vazio.", preferredStyle: .alert)
            let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(buttonOk)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func esqueceuSenhaButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "EsqueciASenhaViewController", sender: nil)
    }
}
