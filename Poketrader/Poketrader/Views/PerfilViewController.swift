//
//  PerfilViewController.swift
//  Poketrader
//
//  Created by AndreLucas on 12/11/20.
//

import UIKit

class PerfilViewController: UIViewController {
    
    // Imagens
    @IBOutlet weak var iconUser: UIImageView!
    private var usuario: User?
    
    // Label
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var consoleLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    
    // TextField
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var consoleTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    
    // to store the current active textfield
    var activeTextField : UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
//        let service: AuthenticationWorker = AuthenticationWorker()
//        self.usuario = service.loadUsuario()
//        
//        if let usuario = self.usuario {
//            self.fullNameTextField.text = usuario.nome
//            self.emailTextField.text = usuario.email
//            self.telephoneTextField.text = String(usuario.telefone)
//        }
        
    }
    
    private func setupView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        fullNameTextField.delegate = self
        emailTextField.delegate = self
        consoleTextField.delegate = self
        telephoneTextField.delegate = self
    }
    
    
    @IBAction func pressedSalvarButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Sucesso", message: "Dados salvos com sucesso.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
}

extension PerfilViewController : UITextFieldDelegate {
    // when user select a textfield, this method will be called
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // set the activeTextField to the selected textfield
        self.activeTextField = textField
    }
    
    // when user click 'done' or dismiss the keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        var shouldMoveViewUp = false
        
        // if active text field is not nil
        if let activeTextField = activeTextField {
            
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            // if the bottom of Textfield is below the top of keyboard, move up
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
}


