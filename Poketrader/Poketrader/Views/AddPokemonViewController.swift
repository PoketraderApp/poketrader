//
//  ViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 01/11/20.
//

import UIKit

class AddPokemonViewController: UIViewController {

    @IBOutlet weak var gameTitleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var helpMessageView: UIView!
    @IBOutlet weak var searchPokemon: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        self.gameTitleTextField.delegate = self
        self.descriptionTextField.delegate = self
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true);
    }

    @IBAction func addPokemon(_ sender: UIButton) {
        let isValid = self.validateFields(textFields: [
            self.gameTitleTextField,
            self.descriptionTextField
        ])
        
        if isValid {
            let alert = UIAlertController(title: "Confirmação", message: "Pokémon adicionado com sucesso!", preferredStyle: .alert)
            
            let button = UIAlertAction(title: "OK", style: .default) { (success) in
                self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(button)
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Alerta", message: "Preencha todos os campos!", preferredStyle: .alert)
            let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(buttonOk)
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func cancelPokemon(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddPokemonViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.gameTitleTextField:
            self.descriptionTextField.becomeFirstResponder()
            break;
        default:
            self.descriptionTextField.becomeFirstResponder()
        }
        
        return true
    }
}

extension AddPokemonViewController {
    func validateFields(textFields: [UITextField]) -> Bool {
        
        for field in textFields {
            guard let fieldText = field.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return false }
            
            if (fieldText.isEmpty) {
                return false
            }
        }
        
        return true
    }
}
