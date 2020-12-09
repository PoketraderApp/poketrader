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
    
    let controller: LoginController = LoginController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        entrarButton.layer.cornerRadius = 4
        entrarButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cadastroButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "LoginVC.CadastroVC", sender: nil)
    }
    
    @IBAction func entrarButton(_ sender: UIButton) {
        
        if self.controller.login(email: self.emailTextField.text, senha: self.senhaTextField.text) {
            self.performSegue(withIdentifier: "LoginVC.FeedVC", sender: nil)
        }
        
        
    }
    
    @IBAction func esqueceuSenhaButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "EsqueciSenhaViewController", sender: nil)
    }
}
