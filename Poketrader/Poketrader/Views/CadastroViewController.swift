//
//  CadastroViewController.swift
//  Poketrader
//
//  Created by Gabriel Duarte on 03/11/20.
//

import UIKit

protocol cadastroViewControllerDelegate: class {
    func usuarioCriado(result: Bool)
}

class CadastroViewController: UIViewController, cadastroViewControllerDelegate {
    @IBOutlet var viewTelaCadastro: UIView!
    @IBOutlet weak var imagePerfil: UIImageView!
    @IBOutlet weak var inserirImagemButton: UIImageView!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var telefoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var senhaLabel: UILabel!
    @IBOutlet weak var verificaEmailLabel: UILabel!
    @IBOutlet weak var verificaSenhaLabel: UILabel!
    @IBOutlet weak var verificaNomeLabel: UILabel!
    @IBOutlet weak var telefoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var cadastrarButton: UIButton!
    
    var singleTap: Any?
    var controller: CadastroController = CadastroController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nomeTextField.delegate = self
        self.telefoneTextField.delegate = self
        self.emailTextField.delegate = self
        self.senhaTextField.delegate = self
        self.senhaTextField.textContentType = .password
        self.senhaTextField.isSecureTextEntry = true
        self.emailTextField.keyboardType = .emailAddress
        self.telefoneTextField.keyboardType = .numberPad
        self.verificaEmailLabel.text = ""
        self.verificaSenhaLabel.text = ""
        self.verificaNomeLabel.text = ""
        self.singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        let size = self.imagePerfil.frame.size.height / 2
        self.imagePerfil.layer.cornerRadius = size
        self.imagePerfil.image = UIImage(named: "profilePic")
        self.cadastrarButton.layer.cornerRadius = 4
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tap)
        self.controller.delegate = self
        self.imagePerfil.isUserInteractionEnabled = true
        self.imagePerfil.addGestureRecognizer(singleTap as! UITapGestureRecognizer)
    }
    
    func usuarioCriado(result: Bool) {
        if result {
            let alert = UIAlertController(title: "Sucesso", message: "Usuario criado com sucesso :D.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Tivemos um problema em criar o seu usuario.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil ))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: Validation
    private func checkFields() -> Bool {
        let obrigatorio:String = "Campo obrigatório"
        var isValid:Bool = true
        if  self.nomeTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true {
            self.verificaNomeLabel.text = obrigatorio
            self.verificaNomeLabel.textColor = UIColor(rgb: 0xffcd00)
            isValid = false
        }
        if self.emailTextField.text?.isEmpty ?? true {
            self.verificaEmailLabel.text = obrigatorio
            self.verificaEmailLabel.textColor = UIColor(rgb: 0xffcd00)
            isValid = false
        }
        if !(self.verificaEmailLabel.text?.isEqual("") ?? true) && !(self.verificaEmailLabel.text?.isEmpty ?? true) {
            isValid = false
        }
        if self.senhaTextField.text?.isEmpty ?? true {
            self.verificaSenhaLabel.text = obrigatorio
            self.verificaSenhaLabel.textColor = UIColor(rgb: 0xffcd00)
            isValid = false
        }
        if !(self.verificaSenhaLabel.text?.isEqual("") ?? true) && !(self.verificaSenhaLabel.text?.isEmpty ?? true) {
            isValid = false
        }
        return isValid
    }
    
    // MARK: actions
    @objc func tapDetected() {
        dismissKeyboard()
        
        EscolherImagem().selecionadorImagem(self){ imagem in
            self.imagePerfil.image = imagem
        }
    }
    
    @IBAction func tappedCadastrarButton(_ sender: UIButton) {
        dismissKeyboard()
        let valida:Bool = checkFields()
        if valida {
            let nome = self.nomeTextField.text ?? ""
            let telefone = self.telefoneTextField.text ?? ""
            let senha = self.senhaTextField.text ?? ""
            let email = self.emailTextField.text ?? ""
            let image = self.imagePerfil.image?.pngData()
            self.controller.cadastrarUsuario(nome: nome, telefone: telefone, email: email, senha: senha, imagem: image) { (error) in
                if let _ = error {
                    let alert = UIAlertController(title: "Error", message: "Tivemos um problema em criar o seu usuario.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil ))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                let alert = UIAlertController(title: "Sucesso", message: "Usuario criado com sucesso :D.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func tappedEntrarButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    
}

// MARK: Text Field Delegate

extension CadastroViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.isEqual(self.emailTextField){
            
            let email: String = textField.text ?? "".lowercased().trimmingCharacters(in: .whitespaces)
            
            let newEmail: String = (email as NSString).replacingCharacters(in: range, with: string).lowercased().trimmingCharacters(in: .whitespaces)
            
            if !self.controller.isValidEmail(newEmail) {
                
                self.verificaEmailLabel.text = "Email inválido"
                
                self.verificaEmailLabel.textColor = UIColor(rgb: 0xffcd00)
            }
            else {
                self.verificaEmailLabel.text = ""
            }
            
        }
        else if textField.isEqual(self.telefoneTextField){
            
            guard let text = textField.text else { return false }
            
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = newString
            textField.text = self.controller.formattedNumber(number: newString)
            
            return false
        }
        
        else if textField.isEqual(self.senhaTextField){
            
            let senha: String = self.senhaTextField.text ?? ""
            
            let newSenha: String = (senha as NSString).replacingCharacters(in: range, with: string)
            
            if (senha.isEqual("") || senha.isEmpty) && (!newSenha.isEqual("") || !newSenha.isEmpty){
                
                self.verificaSenhaLabel.text = ""
            }
            
        }
        
        else if textField.isEqual(self.nomeTextField){
            let nome: String = self.nomeTextField.text ?? ""
            
            let newNome: String = (nome as NSString).replacingCharacters(in: range, with: string)
            
            if (nome.isEqual("") || nome.isEmpty) && (!newNome.isEqual("") || !newNome.isEmpty){
                
                self.verificaNomeLabel.text = ""
            }
            
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.borderStyle = .bezel
        textField.layer.borderColor = UIColor.black.cgColor
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.gray.cgColor
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        
        case self.nomeTextField:
            self.telefoneTextField.becomeFirstResponder()
            
        case self.telefoneTextField:
            self.emailTextField.becomeFirstResponder()
            
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
