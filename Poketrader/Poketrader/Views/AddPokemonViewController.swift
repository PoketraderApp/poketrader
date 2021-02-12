//
//  ViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 01/11/20.
//

import UIKit
import Firebase
import SCLAlertView

class AddPokemonViewController: UIViewController, SelecionarPokemonVCDelegate, UITextViewDelegate {
    @IBOutlet weak var nvTextField: UITextField!
    
    @IBOutlet weak var hpTextField: UITextField!
    @IBOutlet weak var defTextField: UITextField!
    @IBOutlet weak var ataTextField: UITextField!
    @IBOutlet weak var velTextField: UITextField!
    @IBOutlet weak var ataSpTextField: UITextField!
    @IBOutlet weak var defSpTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var gameTitleTextField: UITextField!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    var namePokemon: String?
    @IBOutlet weak var cancelButton: UIButton!
    
    var phoneNumber: String?
    
    private var controller: AddPokemonController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.view.addGestureRecognizer(tap)
        self.pokemonImage.contentMode = .scaleToFill
        self.controller = AddPokemonController()
        self.gameTitleTextField.delegate = self
        self.descriptionTextView.delegate = self
        self.saveButton.layer.cornerRadius = 4
        self.saveButton.clipsToBounds = true
        self.cancelButton.layer.cornerRadius = 4
        self.cancelButton.clipsToBounds = true
        self.nvTextField.keyboardType = .numberPad
        self.hpTextField.keyboardType = .numberPad
        self.defTextField.keyboardType = .numberPad
        self.ataTextField.keyboardType = .numberPad
        self.velTextField.keyboardType = .numberPad
        self.ataSpTextField.keyboardType = .numberPad
        self.defSpTextField.keyboardType = .numberPad
        
        self.nvTextField.delegate = self
        self.hpTextField.delegate = self
        self.defTextField.delegate = self
        self.ataTextField.delegate = self
        self.velTextField.delegate = self
        self.ataSpTextField.delegate = self
        self.defSpTextField.delegate = self
        
        self.descriptionTextView.layer.cornerRadius = 4
        
        self.statusView.layer.cornerRadius = 4
        
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
//                    self.helpMessageView.isHidden = true
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
        ])
        if isValid {
            controller?.savePokemon(name: namePokemon, telefone: self.phoneNumber, url: self.controller?.pokemonURLImage, game: self.gameTitleTextField.text, nv: self.nvTextField.text, hp: self.hpTextField.text, def: self.defTextField.text, ata: self.ataSpTextField.text, vel: self.velTextField.text, defSp: self.defSpTextField.text, ataSp: self.ataSpTextField.text, obs: self.descriptionTextView.text)
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("OK") {}
            alertView.showSuccess("Confirmação", subTitle: "Pokémon adicionado com sucesso!")
        } else {
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("OK") {}
            alertView.showError("Alerta", subTitle: "Preencha todos os campos!")
        }
        self.gameTitleTextField.text = ""
        self.descriptionTextView.text = ""
        self.nvTextField.text = ""
        self.hpTextField.text = ""
        self.defTextField.text = ""
        self.ataTextField.text = ""
        self.velTextField.text = ""
        self.ataSpTextField.text = ""
        self.defSpTextField.text = ""
    }
    
    @IBAction func cancelPokemon(_ sender: UIButton) {
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        var maxLength: Int = 10
        var newString: NSString = ""
        
        if textField != self.gameTitleTextField {
        maxLength = 3
        let currentString: NSString = textField.text! as NSString
        newString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        } else {
            return newString.length <= maxLength
        }
            
        
    }
    
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
