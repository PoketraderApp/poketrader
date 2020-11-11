//
//  CadastroViewController.swift
//  Poketrader
//
//  Created by Gabriel Duarte on 03/11/20.
//

import UIKit

class CadastroViewController: UIViewController {

    // MARK: TextFields e Labels da tela
    
    @IBOutlet var viewTelaCadastro: UIView!
    
    @IBOutlet weak var imagePerfil: UIImageView!
    
    @IBOutlet weak var inserirImagemButton: UIButton!
    
    
    @IBOutlet weak var nomeTextField: UITextField!
    
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var telefoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var senhaLabel: UILabel!
    
    @IBOutlet weak var verificaEmailLabel: UILabel!
    
    @IBOutlet weak var verificaSenhaLabel: UILabel!
    
    
    @IBOutlet weak var telefoneTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var senhaTextField: UITextField!
    
    @IBOutlet weak var cadastrarButton: UIButton!
    
    
//    @IBOutlet weak var telefoneTextField: UITextField!
//
//    @IBOutlet weak var emailTextField: UITextField!
//
//    @IBOutlet weak var verificaEmailLabel: UILabel!
//
//    @IBOutlet weak var senhaTextField: UITextField!
//
//    @IBOutlet weak var verificaSenhaLabel: UILabel!
//
//    @IBOutlet weak var cadastrarButton: UIButton!
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nomeTextField.delegate = self
        self.telefoneTextField.delegate = self
        self.telefoneTextField.keyboardType = .numberPad
        self.emailTextField.delegate = self
        self.senhaTextField.delegate = self
        
        self.verificaEmailLabel.text = ""
        self.verificaSenhaLabel.text = ""
        
        self.inserirImagemButton.backgroundColor = UIColor(rgb: 0x3B4CCA)
        
        self.inserirImagemButton.layer.cornerRadius = 10
        
        self.cadastrarButton.backgroundColor = UIColor(rgb: 0xB3A125)
    
    }
    
    // MARK: actions
    
    @IBAction func tappedInserirImagem(_ sender: UIButton) {
    }
    
    @IBAction func tappedCadastrarButton(_ sender: UIButton) {
    }
    
    @IBAction func tappedEntrarButton(_ sender: Any) {
    }
    
    
    //MARK: Outras Funções
    
    private func isValidEmail(_ email: String) -> Bool{
        
        let emailRegEx = "\\b([a-z 0-9]+)((\\.|_)?([a-z 0-9]+))+@([a-z]+)(\\.([a-z]{2,}))+\\b"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        
        return emailTest.evaluate(with: email)
    }
    
    private func formattedNumber(number: String) -> String {
        
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(##) ##### ####"
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            
            if ch == "#" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
                
            } else {
                result.append(ch)
            }
        }
        return result
    }
    

}

// MARK: delegates

extension CadastroViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.isEqual(self.emailTextField){
            
            let email: String = textField.text ?? "".lowercased().trimmingCharacters(in: .whitespaces)
            
            let newEmail: String = (email as NSString).replacingCharacters(in: range, with: string)
            
            if !isValidEmail(newEmail) {
                
                self.verificaEmailLabel.text = "Email inválido"
                
                self.verificaEmailLabel.textColor = .red
            }
            else {
                self.verificaEmailLabel.text = ""
            }
            
        }
        else if textField.isEqual(self.telefoneTextField){
            
            guard let text = textField.text else { return false }
            
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = formattedNumber(number: newString)
            return false
        }
        
        return true
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        
        case self.nomeTextField:
            self.telefoneTextField.becomeFirstResponder()
            
        case self.telefoneTextField:
            self.emailTextField.becomeFirstResponder()
        
        case self.emailTextField:
            self.senhaTextField.becomeFirstResponder()
            
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    
    
}

