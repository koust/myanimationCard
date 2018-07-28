//
//  myanimationCard.swift
//  myanimationCard
//
//  Created by Batuhan Saygili on 29.07.2018.
//  Copyright © 2018 Batuhan Saygili. All rights reserved.
//

import UIKit

public protocol myInfoSlideDelegate {
    func handlerAction(sender:UITapGestureRecognizer)
}


open class myanimationCard: UIViewController {

    public var delegate:myInfoSlideDelegate?
    
    public var yourView                 = UIView()

    private var myView                  = UIView()
    private var myViewHeight:CGFloat    = 80
    private var myViewBg                = UIColor.black
    private var leftAnchor:NSLayoutConstraint?
    private var rightAnchor:NSLayoutConstraint?
    private var heightAnchor:NSLayoutConstraint?
    private var topAnchor:NSLayoutConstraint?
    private var isOpen                  = 0
    
 
    
    public func show(){

        createView()
        swipe()
    }

    private func createView(){
        myView.backgroundColor          = myViewBg
        myView.clipsToBounds            = true
        myView.layer.cornerRadius       = 10
        myView.layer.maskedCorners      = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
        

        
        
        myView.translatesAutoresizingMaskIntoConstraints                                      = false
        
        yourView.addSubview(myView)
        
   
        
        myView.bottomAnchor.constraint(equalTo: yourView.bottomAnchor, constant: 0).isActive  = true
        leftAnchor   = myView.leftAnchor.constraint(equalTo: yourView.leftAnchor, constant: 10)
        leftAnchor?.isActive     = true
        rightAnchor  = myView.rightAnchor.constraint(equalTo: yourView.rightAnchor, constant: -10)
        rightAnchor?.isActive    = true
        heightAnchor = myView.heightAnchor.constraint(greaterThanOrEqualToConstant: myViewHeight)
        heightAnchor?.isActive   = true

        

    }
    
    private func swipe(){
        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
            gesture.direction = direction
            self.yourView.addGestureRecognizer(gesture)
        }
    }
    
    @objc  private func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        
        if gesture.direction == .up {
            animationUp()
        }else if gesture.direction == .down {
            if isOpen == 1 {
            animationDown()
            }
        }
        
    }
    
    @objc private func handlerAction(sender:UITapGestureRecognizer){
        print("batux")
        delegate?.handlerAction(sender: sender)
        
//        if gesture.direction == .left {
//
//
//        }else if gesture.direction == .right {
//
//        }
        
    }


    
    private func animationUp(){
        UIView.animate(withDuration: 1, delay: 0, options: [],
                animations: {
                    self.heightAnchor?.isActive     = false
                    self.rightAnchor?.constant      = 0
                    self.leftAnchor?.constant       = 0
                    self.topAnchor = self.myView.topAnchor.constraint(equalTo: self.yourView.topAnchor, constant: 180)
                    self.topAnchor?.isActive        = true
                    self.isOpen                     = 1
                    
                },
                completion: nil
        )
    }
    
    
    
    private func animationDown(){
        UIView.animate(withDuration: 1, delay: 0, options: [],
                       animations: {
                        self.heightAnchor?.isActive     = false
                        self.rightAnchor?.constant      = -10
                        self.leftAnchor?.constant       = 10
                        self.heightAnchor?.isActive     = true
                        self.topAnchor?.isActive        = false
                        self.isOpen                     = 0
        },
                       completion: nil
        )
    }

}




