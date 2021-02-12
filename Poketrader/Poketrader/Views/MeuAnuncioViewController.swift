//
//  MeuAnuncioViewController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 12/11/20.
//

import UIKit

class MeuAnuncioViewController: BaseViewController, UITextFieldDelegate{
    @IBOutlet weak var nomePokemonLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var nvTextField: UITextField!
    @IBOutlet weak var hpTextField: UITextField!
    @IBOutlet weak var defTextField: UITextField!
    @IBOutlet weak var ataTextField: UITextField!
    @IBOutlet weak var velTextField: UITextField!
    @IBOutlet weak var ataSpTextField: UITextField!
    @IBOutlet weak var defSpTextField: UITextField!

    @IBOutlet weak var obsTextView: UILabel!
    //    @IBOutlet weak var obsTextView: UITextField!
    
//    @IBOutlet weak var obsTextView: UITextView!
   
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
       
    private var oferta: OfertaElement?
    var controller: MeuAnuncioController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusView.layer.cornerRadius = 4
        self.statusView.clipsToBounds = true
        self.editButton.layer.cornerRadius = 4
        self.editButton.clipsToBounds = true
        self.deleteButton.layer.cornerRadius = 4
        self.deleteButton.clipsToBounds = true
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
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.showLoading()
        self.controller?.loadAnuncio(completion: { (oferta, erro) in
            if let _oferta = oferta {
                self.oferta = _oferta
                DispatchQueue.main.async {
                    self.nvTextField.text = _oferta.nv
                    self.hpTextField.text = _oferta.hp
                    self.defTextField.text = _oferta.def
                    self.ataTextField.text = _oferta.ata
                    self.velTextField.text = _oferta.vel
                    self.ataSpTextField.text = _oferta.ataSp
                    self.defSpTextField.text = _oferta.defSp
                    self.obsTextView.text = oferta?.observacoes
                    self.nomePokemonLabel.text = oferta?.pokemon?.name
                    let urlText = oferta?.pokemon?.sprite! ?? ""
                    let url = URL(string: urlText)
                    if let _url = url {
                        self.downloadImage(from: _url)
                        self.hiddenLoading()
                    }
                }
            } else {
                print("\(String(describing: erro))")
            }
        })
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let maxLength = 3
        var newString: NSString = ""
        let currentString: NSString = textField.text! as NSString
        newString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.pokemonImage.image = UIImage(data: data)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MeuAnuncioVC.EditarVC" {
            if let vc = segue.destination as? EdicaoPokemonViewController {
                vc.controller = OfertasUsuarioController()
                vc.controller?.setOferta(ofer: self.oferta ?? OfertaElement())
            }
        }
    }
    
    @IBAction func pressedEditarButton(_ sender: UIButton) {
        self.controller?.editOffer(nv: self.nvTextField.text!, hp: self.hpTextField.text!, def: self.defTextField.text!, ata: self.ataTextField.text!, vel: self.velTextField.text!, ataSp: self.ataSpTextField.text!, defSp: self.defSpTextField.text!, obs: self.obsTextView.text!)
    }
    
    @IBAction func pressedExcluirButton(_ sender: UIButton) {
        self.controller!.removeOffer(id: self.oferta!.id!)
    }
}

