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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        entrarButton.layer.cornerRadius = 4
        entrarButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cadastroButton(_ sender: UIButton) {
        
    }
    
    @IBAction func entrarButton(_ sender: UIButton) {
        
    }
    
    @IBAction func esqueceuSenhaButton(_ sender: UIButton) {
        
    }
}
