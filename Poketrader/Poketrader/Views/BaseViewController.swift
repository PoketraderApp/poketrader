//
//  BaseViewController.swift
//  Poketrader
//
//  Created by Bruno da Fonseca on 11/12/20.
//

import UIKit

class BaseViewController: UIViewController {
    
    var loadingView: LoadView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showLoading() {
           self.loadingView = UINib(nibName: "LoadView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? LoadView
           self.loadingView?.frame = self.view.frame
           self.view.addSubview(self.loadingView ?? UIView())
           self.loadingView?.showLoading()
       }
       
       func hiddenLoading() {
           self.loadingView?.hiddenLoading()
           self.loadingView?.isHidden = true
       }
}
