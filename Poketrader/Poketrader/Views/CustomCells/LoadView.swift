//
//  LoadView.swift
//  Poketrader
//
//  Created by Bruno da Fonseca on 11/12/20.
//

import UIKit
import Lottie

class LoadView: UIView {

    @IBOutlet weak var animationLoadView: AnimationView!
    
    func showLoading() {
        self.animationLoadView.loopMode = .loop
        self.animationLoadView.play()
    }
    
    func hiddenLoading() {
        self.animationLoadView.stop()
        
    }
    

}
