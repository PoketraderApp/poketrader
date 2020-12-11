//
//  EdicaoPokemonVC.swift
//  Poke
//
//  Created by Bruno da Fonseca on 13/11/20.
//  Copyright © 2020 digital house. All rights reserved.
//

import UIKit

class EdicaoPokemonVC: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var tittleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var gameTitle: String = "Pokemon Blue"
    var shortDescription: String = "Tenho interesse em trocar."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tittleTextField.delegate = self
        self.descriptionTextView.delegate = self

        
        // self.avatarImageView.image = UIImage(named: "charmeleon")
        self.tittleTextField.text = self.gameTitle
        self.descriptionTextView.text = self.shortDescription
        
        self.saveButton.layer.cornerRadius = 5
        self.cancelButton.layer.cornerRadius = 5
       
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func editPokemon(_ sender: UIButton) {
        
        self.gameTitle =  String(describing: self.tittleTextField.text)
        self.shortDescription = String(describing: self.descriptionTextView.text)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelEditPokemon(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EdicaoPokemonVC: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case self.tittleTextField:
            self.descriptionTextView.becomeFirstResponder()
        case self.descriptionTextView:
            self.descriptionTextView.resignFirstResponder()
        default:
            return false
        }
        
        return true
    }
}
