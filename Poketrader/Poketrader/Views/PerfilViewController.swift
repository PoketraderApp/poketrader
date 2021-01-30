//
//  PerfilViewController.swift
//  Poketrader
//
//  Created by AndreLucas on 12/11/20.
//

import UIKit
import Firebase
import SDWebImage

class PerfilViewController: BaseViewController {
    
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
    
    // Button
    @IBOutlet weak var editarOuSalvarUiButton: UIButton!
    var singleTap: Any?
    
    // to store the current active textfield
    var activeTextField : UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.showLoading()
        self.bloquearTextField()
        let size = self.iconUser.frame.size.height / 2
        self.iconUser.layer.cornerRadius = size
        self.fullNameTextField.text = Auth.auth().currentUser?.displayName
        self.emailTextField.text = Auth.auth().currentUser?.email
        self.telephoneTextField.text = Auth.auth().currentUser?.phoneNumber
        self.fetchImage()
        self.getTelephone()
        self.singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        
    }
    
    
    @IBAction func buttonLogout(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
            UIApplication.shared.keyWindow?.rootViewController = loginViewController
        } catch let signOutError as NSError {
            print("ERROR %@", signOutError)
        }
    }
    
    //Action
    @objc func tapDetected() {
        print("Imageview Clicked")
    }
    
    private func getTelephone() {
        if let uid = (Auth.auth().currentUser?.uid){
            let db = Firestore.firestore()
            db.collection("telefones").document(uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    if let teamInfo = document.data()?["telefone"] {
                        let telefone = teamInfo as? String ?? ""
                        self.telephoneTextField.text = telefone
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    private func fetchImage() {
        //get DAta
        //converter o data em imagem
        //set imagem no imageView
        
        if let uid = (Auth.auth().currentUser?.uid){
            let profileImageStorageRef = Storage.storage().reference().child("profile_image_urls").child("\(uid).png")
            
            profileImageStorageRef.downloadURL { url, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let _url = url {
                        let data = try? Data(contentsOf: _url)
                        if let _data = data {
                            let image = UIImage(data: _data)
                            self.iconUser.image = image
                            self.hiddenLoading()
                        }
                    }
                }
            }
            
        }
        
        
    }
    
    private func setupView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.fullNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.consoleTextField.delegate = self
        self.telephoneTextField.delegate = self
        
        self.telephoneTextField.keyboardType = .numberPad
    }
    
    fileprivate func liberarTextField() {
        self.fullNameTextField.isUserInteractionEnabled = true
        self.fullNameTextField.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) /* #ffffff */
        
        self.consoleTextField.isUserInteractionEnabled = true
        self.consoleTextField.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) /* #ffffff */
        
        self.telephoneTextField.isUserInteractionEnabled = true
        self.telephoneTextField.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) /* #ffffff */
        iconUser.isUserInteractionEnabled = true
        iconUser.addGestureRecognizer(singleTap as! UITapGestureRecognizer)
    }
    
    fileprivate func bloquearTextField() {
        self.fullNameTextField.isUserInteractionEnabled = false
        self.fullNameTextField.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 200/255, alpha: 1.0) /* #c6c6c8 */
        self.fullNameTextField.layer.borderWidth = 0.1
        //        self.fullNameTextField.layer.cornerRadius = 4
        self.fullNameTextField.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) /* #ffffff */
        
        self.emailTextField.isUserInteractionEnabled = false
        self.emailTextField.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 200/255, alpha: 1.0) /* #c6c6c8 */
        self.emailTextField.layer.borderWidth = 0.1
        self.emailTextField.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) /* #ffffff */
        
        self.consoleTextField.isUserInteractionEnabled = false
        self.consoleTextField.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 200/255, alpha: 1.0) /* #c6c6c8 */
        self.consoleTextField.layer.borderWidth = 0.1
        self.consoleTextField.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) /* #ffffff */
        
        self.telephoneTextField.isUserInteractionEnabled = false
        self.telephoneTextField.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 200/255, alpha: 1.0) /* #c6c6c8 */
        self.telephoneTextField.layer.borderWidth = 0.1
        self.telephoneTextField.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) /* #ffffff */
        iconUser.isUserInteractionEnabled = false
    }
    
    @IBAction func pressedSalvarButton(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else {
            return
        }
        if buttonTitle == "Editar" {
            self.liberarTextField()
            sender.setTitle("Salvar", for: .normal)
        } else {
            //            self.bloquearTextField()
            //            sender.titleLabel?.text = "Editar"
            let user = User()
            user.nome = self.fullNameTextField.text
            user.email = self.emailTextField.text
            user.console = self.consoleTextField.text
            user.telefone = self.telephoneTextField.text
            //            Auth.auth().updateCurrentUser(user, completion: { (error) in
            //                print("error \(error)")
            //            })
            let alert = UIAlertController(title: "Sucesso", message: "Dados salvos com sucesso.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
}

extension PerfilViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.fullNameTextField:
            self.emailTextField.becomeFirstResponder()
        case self.emailTextField:
            self.consoleTextField.becomeFirstResponder()
        case self.consoleTextField:
            self.telephoneTextField.becomeFirstResponder()
        default:
            self.telephoneTextField.resignFirstResponder()
        }
        return true
    }
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


