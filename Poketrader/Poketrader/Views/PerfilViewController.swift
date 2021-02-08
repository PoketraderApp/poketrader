//
//  PerfilViewController.swift
//  Poketrader
//
//  Created by AndreLucas on 12/11/20.
//

import UIKit
import Firebase
import SCLAlertView

protocol perfilViewControllerDelegate: class {
    func usuarioCriado(result: Bool)
}

class PerfilViewController: BaseViewController {
    
    // Imagens
    @IBOutlet weak var iconUser: UIImageView!
    @IBOutlet weak var editarIconUser: UIImageView!
    
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
    
    // Variaveis
    private var usuario: User?
    var singleTap: Any?
    var perfil: PerfilController = PerfilController()
    
    // to store the current active textfield
    var activeTextField : UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.showLoading()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.bloquearTextField()
        let size = self.iconUser.frame.size.height / 2
        self.iconUser.layer.cornerRadius = size
        self.fullNameTextField.text = Auth.auth().currentUser?.displayName
        self.emailTextField.text = Auth.auth().currentUser?.email
        self.telephoneTextField.text = Auth.auth().currentUser?.phoneNumber
        self.fetchImage()
        self.getTelephone()
        self.editarOuSalvarUiButton.layer.cornerRadius = 4
        self.editarOuSalvarUiButton.clipsToBounds = true
        
        self.singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        
    }
    
    @IBAction func buttonLogout(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
            let windows = UIApplication.shared.windows.first { $0.isKeyWindow }
            windows?.rootViewController = loginViewController
        } catch let signOutError as NSError {
            print("ERROR %@", signOutError)
        }
    }
    
    //Action
    @objc func tapDetected() {
        dismissKeyboard()
        EscolherImagem().selecionadorImagem(self){ imagem in
            self.iconUser.image = imagem
        }
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
    
    private func checkFields() -> Bool {
        var isValid:Bool = true
        if  self.fullNameTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true {
            print("nome invalido")
            isValid = false
        }
        
        if (self.telephoneTextField.text?.isEqual("") ?? true) && (self.telephoneTextField.text?.isEmpty ?? true) {
            print("telephone invalido")
            isValid = false
        }
        
        return isValid
    }
    
    private func fetchImage() {
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
        self.editarIconUser.isHidden = false
        
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
        self.editarIconUser.isHidden = true
        
        self.editarOuSalvarUiButton.backgroundColor = UIColor(rgb: 0x84A9AC)
        self.editarOuSalvarUiButton.setTitle("Editar", for: .normal)
        
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
            sender.backgroundColor = UIColor(rgb: 0xCAE8D5)
        } else {
            let valido:Bool = checkFields()
            if valido {
                let nome = self.fullNameTextField.text ?? ""
                let telefone = self.telephoneTextField.text ?? ""
                let email = self.emailTextField.text ?? ""
                let image = self.iconUser.image?.pngData()
                let console = self.consoleTextField.text ?? ""
                self.perfil.atualizarUsuario(nome: nome, telefone: telefone, email: email, console: console, imagem: image) { (error) in
                    
                    if let _ = error {
                        SCLAlertView().showError("Alerta", subTitle: "Tivemos um problema em atualizar seu perfil.")
                        
                        return
                    }
                    self.bloquearTextField()
                    
                    let appearance = SCLAlertView.SCLAppearance(
                        showCloseButton: false
                        //                        showCircularIcon: true
                    )
                    let alertView = SCLAlertView(appearance: appearance)
                    //                    let alertViewIcon = UIImage(named: "poke")
                    alertView.addButton("OK") {}
                    alertView.showSuccess("", subTitle: "Usuario atualizado com sucesso")
                }
            } else {
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false
                )
                let alertView = SCLAlertView(appearance: appearance)
                alertView.addButton("OK") {}
                alertView.showError("Alerta", subTitle: "Preencha todos os campos obrigatorios!")
            }
        }
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

extension PerfilViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isEqual(self.telephoneTextField){
            guard let text = textField.text else { return false }
            
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = newString
            textField.text = self.perfil.formattedNumber(number: newString)
            
            return false
        }
        else if textField.isEqual(self.fullNameTextField){
            let nome: String = self.fullNameTextField.text ?? ""
            let newNome: String = (nome as NSString).replacingCharacters(in: range, with: string)
            if (nome.isEqual("") || nome.isEmpty) && (!newNome.isEqual("") || !newNome.isEmpty){
                return false
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.fullNameTextField:
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
    
}


