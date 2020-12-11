//
//  LoginViewController.swift
//  Poketrader
//
//  Created by Rodolpho on 11/11/20.
//
import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var entrarButton: UIButton!
    
    @IBOutlet weak var backgroudImageLogin: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()

        entrarButton.layer.cornerRadius = 4
        entrarButton.clipsToBounds = true
        backgroudImageLogin.image = UIImage(named: "imagemLogin")
        emailTextField.delegate = self
        senhaTextField.delegate = self
        entrarButton.backgroundColor = UIColor(rgb: 0xFF453A)

        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
                self.view.addGestureRecognizer(tap)
        
        self.hiddenLoading()
        
        
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
        
        self.showLoading()
        
       if self.checkFields() {
            LoginController(email: self.emailTextField.text, senha: self.senhaTextField.text).login { (result, error ) in
                
                if result {
                    DispatchQueue.main.async {
                        
                        self.performSegue(withIdentifier: "LoginVC.FeedVC", sender: nil)
                        self.hiddenLoading()
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        let alert =  UIAlertController(title: "Alerta", message: "Usuário ou senha inválidos", preferredStyle: .alert)
                        let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(buttonOk)
                        self.present(alert, animated: true, completion: nil)
                        self.hiddenLoading()
                    }
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
