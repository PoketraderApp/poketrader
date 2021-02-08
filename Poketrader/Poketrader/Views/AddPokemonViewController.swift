//
//  ViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 01/11/20.
//

import UIKit
import Firebase

class AddPokemonViewController: UIViewController, SelecionarPokemonVCDelegate, UITextViewDelegate {
    @IBOutlet weak var gameTitleTextField: UITextField!
    
    @IBOutlet weak var nvtextField: UITextField!
    @IBOutlet weak var hpTextField: UITextField!
    @IBOutlet weak var atatextField: UITextField!
    @IBOutlet weak var defTextField: UITextField!
    @IBOutlet weak var velTextField: UITextField!
    @IBOutlet weak var defSptextField: UITextField!
    @IBOutlet weak var ataSpTextField: UITextField!
//    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var helpMessageView: UIView!
    @IBOutlet weak var searchPokemon: UISearchBar!
    
    @IBOutlet weak var saveButton: UIButton!
    var namePokemon: String?
    @IBOutlet weak var cancelButton: UIButton!
    
    var phoneNumber: String?
    
    private var controller: AddPokemonController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        self.pokemonImage.contentMode = .scaleToFill
        self.controller = AddPokemonController()
        self.gameTitleTextField.delegate = self
        self.descriptionTextView.delegate = self
        self.saveButton.layer.cornerRadius = 4
        self.saveButton.clipsToBounds = true
        self.cancelButton.layer.cornerRadius = 4
        self.cancelButton.clipsToBounds = true
        self.getTelephone()
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true);
    }
    
    func sendDataToCadastroVC(nomePokemon: String) {
        print("cliquei no >>>>>>>>\(nomePokemon)")
        self.controller?.getPokemonData(nomePokemon: nomePokemon){ (result, erro) in
            if(result){
                let url = URL(string: self.controller?.pokemonURLImage ?? "")
                if let _url = url {
                    self.helpMessageView.isHidden = true
                    self.pokemonImage.load(url: _url)
                    self.namePokemon = nomePokemon
                }
            }
            else{
                print("deu erro")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier ==  "CadastrarVC.SelecionarPokemonVC"){
            let selecionarPokemonVC: SelecionarPokemonVC = segue.destination as! SelecionarPokemonVC
            selecionarPokemonVC.delegate = self
        }
    }

    @IBAction func searchAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "CadastrarVC.SelecionarPokemonVC", sender: nil)
        
    }
    @IBAction func addPokemon(_ sender: UIButton) {
        let isValid = self.validateFields(textFields: [
            self.gameTitleTextField
//            self.descriptionTextView
        ])
        if isValid {
            controller?.savePokemon(name: namePokemon, telefone: self.phoneNumber, url: self.controller?.pokemonURLImage, game: self.gameTitleTextField.text, nv: self.nvtextField.text, hp: self.hpTextField.text, def: self.defTextField.text, ata: self.ataSpTextField.text, vel: self.velTextField.text, defSp: self.defSptextField.text, ataSp: self.ataSpTextField.text, obs: self.descriptionTextView.text)
            let alert = UIAlertController(title: "Confirmação", message: "Pokémon adicionado com sucesso!", preferredStyle: .alert)
            let button = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(button)
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Alerta", message: "Preencha todos os campos!", preferredStyle: .alert)
            let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(buttonOk)
            self.present(alert, animated: true, completion: nil)
        }
        self.gameTitleTextField.text = ""
        self.descriptionTextView.text = ""
    }
    
    @IBAction func cancelPokemon(_ sender: UIButton) {
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getTelephone() {
        if let uid = (Auth.auth().currentUser?.uid){
            let db = Firestore.firestore()
            db.collection("telefones").document(uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    if let teamInfo = document.data()?["telefone"] {
                        let telefone = teamInfo as? String ?? ""
                        self.phoneNumber = telefone
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
}

extension AddPokemonViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.gameTitleTextField:
            self.descriptionTextView.becomeFirstResponder()
            break;
        default:
            self.descriptionTextView.becomeFirstResponder()
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

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
