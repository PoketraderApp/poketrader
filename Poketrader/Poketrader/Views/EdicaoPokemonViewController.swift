//
//  EdicaoPokemonViewController.swift
//  Poke
//
//  Created by Bruno da Fonseca on 13/11/20.
//  Copyright © 2020 digital house. All rights reserved.
//

import UIKit

class EdicaoPokemonViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var tittleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameTextLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var controller: OfertasUsuarioController?
    
    var gameTitle: String = "Pokemon Blue"
    var shortDescription: String = "Tenho interesse em trocar."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tittleTextField.delegate = self
        self.descriptionTextView.delegate = self
        self.tittleTextField.text = self.controller?.getOferta()?.nome
        self.descriptionTextView.text = self.controller?.getOferta()?.observacoes
        self.nameTextLabel.text = self.controller?.getOferta()?.pokemon?.name
        
        self.saveButton.layer.cornerRadius = 5
        self.cancelButton.layer.cornerRadius = 5
       
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tap)
        
        
        
        let urlText = self.controller?.getOferta()?.pokemon?.sprite! ?? ""
        let url = URL(string: urlText)
        
        if let _url = url {
            self.downloadImage(from: _url)
        }
            
    }
    
    
    @IBAction func editPokemon(_ sender: UIButton) {
        self.controller?.editOffer(obs: self.descriptionTextView.text) 
        
        
        self.gameTitle =  String(describing: self.tittleTextField.text)
        self.shortDescription = String(describing: self.descriptionTextView.text)
//        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelEditPokemon(_ sender: UIButton) {
        
//        self.dismiss(animated: true, completion: nil)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.avatarImageView.image = UIImage(data: data)
            }
        }
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

extension EdicaoPokemonViewController: UITextFieldDelegate, UITextViewDelegate {
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
