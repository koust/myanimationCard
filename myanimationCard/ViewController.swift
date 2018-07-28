//
//  ViewController.swift
//  myanimationCard
//
//  Created by Batuhan Saygili on 28.07.2018.
//  Copyright © 2018 Batuhan Saygili. All rights reserved.
//

import UIKit

class ViewController: UIViewController,myInfoSlideDelegate {

    
    let myanimationCardVC       = myanimationCard()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myanimationCardVC.delegate  = self
        myanimationCardVC.yourView  = self.view
        myanimationCardVC.show()
     
    }

    func handlerAction(sender: UITapGestureRecognizer) {
        print("run")
    }

}

