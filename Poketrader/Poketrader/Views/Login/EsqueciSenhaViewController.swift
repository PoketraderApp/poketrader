//
//  EsqueciSenhaVC.swift
//  Poketrader
//
//  Created by Rodolpho on 08/12/20.
//

import UIKit

class EsqueciSenhaViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetarSenhaButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resetarSenhaButton.layer.cornerRadius = 4
        resetarSenhaButton.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetarSenhaButton(_ sender: UIButton) {
        
    }
    
}
