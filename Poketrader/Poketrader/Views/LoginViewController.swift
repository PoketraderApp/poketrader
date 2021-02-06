//
//  LoginViewController.swift
//  Poketrader
//
//  Created by Rodolpho on 11/11/20.
//
import UIKit
import Firebase

class LoginViewController: BaseViewController {
    @IBOutlet weak var backgroudImageLogin: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var entrarButton: UIButton!
    @IBOutlet weak var cadastrarButton: UIButton!
    @IBOutlet weak var esqueciSenhaButton: UIButton!
    
    var usuarioVC: User?
    
//    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var senhaTextField: UITextField!
//    @IBOutlet weak var entrarButton: UIButton!
//    
//    @IBOutlet weak var backgroudImageLogin: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()

        entrarButton.layer.cornerRadius = 4
        entrarButton.clipsToBounds = true
<<<<<<< HEAD
        
        
        self.emailTextField.text = "teste@gmail.com"
        self.senhaTextField.text = "12345678"
=======
        backgroudImageLogin.image = UIImage(named: "poketrade_logo")
        emailTextField.delegate = self
        senhaTextField.delegate = self
        
        self.senhaTextField.textContentType = .password
        self.senhaTextField.isSecureTextEntry = true
        
//        entrarButton.backgroundColor = UIColor(rgb: 0xFF453A)

        cadastrarButton.layer.cornerRadius = 4
        cadastrarButton.clipsToBounds = true

        esqueciSenhaButton.layer.cornerRadius = 4
        esqueciSenhaButton.clipsToBounds = true
        
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
                self.view.addGestureRecognizer(tap)
        
        
        
        self.hiddenLoading()
>>>>>>> develop
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
        dismissKeyboard()
        self.showLoading()
        
        if self.checkFields() {
            let email = self.emailTextField.text!
            let senha = self.senhaTextField.text!
            LoginController().login(email: email, senha: senha) { ( error ) in
                if let _ = error {
                    DispatchQueue.main.async {
                        let alert =  UIAlertController(title: "Alerta", message: "Usuário ou senha inválidos", preferredStyle: .alert)
                        let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(buttonOk)
                        self.present(alert, animated: true, completion: nil)
                        self.hiddenLoading()
                    }
                    return
                }
                DispatchQueue.main.async {
//                    Configuration.value(defaultValue: usuario, forKey: "usuarioSalvoLocal")
                    self.performSegue(withIdentifier: "LoginVC.FeedVC", sender: nil)
                    self.hiddenLoading()
                }
            }
         } else {
            
            let alert =  UIAlertController(title: "Alerta", message: "Campos obrigatórios vazio.", preferredStyle: .alert)
            let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(buttonOk)
            self.present(alert, animated: true, completion: nil)
            self.hiddenLoading()
        }
    }
    
    
    @IBAction func esqueceuSenhaButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "EsqueciASenhaViewController", sender: nil)
    }
    
    private func dismissKeyboard(){
        self.view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.emailTextField:
            self.senhaTextField.becomeFirstResponder()
            
        case self.senhaTextField:
            self.senhaTextField.resignFirstResponder()
            
        default:
            
            break
        }
        return true
    }
    
}
