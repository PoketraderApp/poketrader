//
//  LoginViewController.swift
//  Poketrader
//
//  Created by Rodolpho on 11/11/20.
//
import UIKit
import Firebase
import SCLAlertView

class LoginViewController: BaseViewController {
    @IBOutlet weak var backgroudImageLogin: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var entrarButton: UIButton!
    @IBOutlet weak var cadastrarButton: UIButton!
    @IBOutlet weak var esqueciSenhaButton: UIButton!
    
    var usuarioVC: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        entrarButton.layer.cornerRadius = 4
        entrarButton.clipsToBounds = true
        backgroudImageLogin.image = UIImage(named: "poketrade_logo")
        emailTextField.delegate = self
        senhaTextField.delegate = self
        self.senhaTextField.textContentType = .password
        self.senhaTextField.isSecureTextEntry = true
        cadastrarButton.layer.cornerRadius = 4
        cadastrarButton.clipsToBounds = true
        esqueciSenhaButton.layer.cornerRadius = 4
        esqueciSenhaButton.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
                self.view.addGestureRecognizer(tap)
        self.hiddenLoading()
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
        let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false
                )
        self.showLoading()
        if self.checkFields() {
            let email = self.emailTextField.text!
            let senha = self.senhaTextField.text!
            LoginController().login(email: email, senha: senha) { ( error ) in
                if let _ = error {
                    DispatchQueue.main.async {
                        let alertView = SCLAlertView(appearance: appearance)
                        alertView.addButton("OK") {}
                        alertView.showError("Alerta", subTitle: "Usuário ou senha inválidos")
                        self.hiddenLoading()
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "LoginVC.FeedVC", sender: nil)
                    self.hiddenLoading()
                }
            }
         } else {
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("OK") {}
            alertView.showError("Alerta", subTitle: "Campos obrigatórios vazio.")
            
//            let alert =  UIAlertController(title: "Alerta", message: "Campos obrigatórios vazio.", preferredStyle: .alert)
//            let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alert.addAction(buttonOk)
//            self.present(alert, animated: true, completion: nil)
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
