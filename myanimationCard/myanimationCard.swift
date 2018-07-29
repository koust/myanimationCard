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
    public var cornerRadius:CGFloat     = 10
    public var myTitle                  = "Title"
    public var myDesc                   = "While working on a project making multiple API calls and parsing text from the API response I ran into a problem with the unpredictable amount of text i was receiving. Some of the text easily fit in 2–3 lines and other text required 6–7 lines or more to properly fit. "
    public var myViewHeight:CGFloat     = 80
    public var myViewBg                 = UIColor.black
    public var myTitleColor             = UIColor.white
    public var myDescColor              = UIColor.white

    private var myView                  = UIView()
    private var contentTitle            = UILabel()
    private var contentDesc             = UILabel()
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
        myView.layer.cornerRadius       = cornerRadius
        myView.layer.maskedCorners      = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
        

        
        
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        yourView.addSubview(myView)
        
   
        
        myView.bottomAnchor.constraint(equalTo: yourView.bottomAnchor, constant: 0).isActive  = true
        leftAnchor   = myView.leftAnchor.constraint(equalTo: yourView.leftAnchor, constant: 10)
        leftAnchor?.isActive     = true
        rightAnchor  = myView.rightAnchor.constraint(equalTo: yourView.rightAnchor, constant: -10)
        rightAnchor?.isActive    = true
        heightAnchor = myView.heightAnchor.constraint(greaterThanOrEqualToConstant: myViewHeight)
        heightAnchor?.isActive   = true

        let gesture = UITapGestureRecognizer(target: self, action: #selector(handlerAction))
        myView.addGestureRecognizer(gesture)

    }
    
    private func createContent(){
        contentTitle.translatesAutoresizingMaskIntoConstraints              = false
        contentDesc.translatesAutoresizingMaskIntoConstraints               = false
        
        contentTitle.text               = myTitle
        contentTitle.textColor          = myTitleColor
        contentDesc.text                = myDesc
        contentDesc.textColor           = myDescColor
        contentDesc.numberOfLines       = 0
        contentDesc.lineBreakMode       = .byWordWrapping
        contentDesc.textAlignment       = .justified
        
        
        
        myView.addSubview(contentTitle)
        myView.addSubview(contentDesc)
        
        contentTitle.topAnchor.constraint(equalTo: myView.topAnchor, constant: 15).isActive         = true
        contentTitle.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 15).isActive       = true
        contentTitle.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -15).isActive    = true
        
        contentDesc.topAnchor.constraint(equalTo: contentTitle.bottomAnchor, constant: 15).isActive = true
        contentDesc.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 15).isActive        = true
        contentDesc.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -15).isActive     = true
        contentDesc.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -25).isActive   = true
        
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
            if isOpen == 0 {
            animationUp()
            }
        }else if gesture.direction == .down {
            if isOpen == 1 {
            animationDown()
            }
        }
        
    }
    
    @objc private func handlerAction(sender:UITapGestureRecognizer){
        delegate?.handlerAction(sender: sender)
        if isOpen != 1 {
            animationUp()
        }
    }


    
    private func animationUp(){
        UIView.animate(withDuration: 0.6, delay: 0, options: [],
                animations: {
                    self.heightAnchor?.isActive     = true
                    self.rightAnchor?.constant      = 0
                    self.leftAnchor?.constant       = 0
//                    self.topAnchor = self.myView.topAnchor.constraint(equalTo: self.yourView.topAnchor, constant: 180)
//                    self.topAnchor?.isActive        = true
                    self.isOpen                     = 1
                    self.myView.layer.cornerRadius  = 0
                    self.createContent()
                    self.yourView.layoutIfNeeded()
                },
                completion: nil
        )
    }
    
    
    
    private func animationDown(){
        UIView.animate(withDuration: 0.6, delay: 0, options: [],
                       animations: {
                        self.heightAnchor?.isActive     = false
                        self.rightAnchor?.constant      = -10
                        self.leftAnchor?.constant       = 10
                        self.heightAnchor?.isActive     = true
                        self.topAnchor?.isActive        = false
                        self.isOpen                     = 0
                        self.myView.layer.cornerRadius  = self.cornerRadius
                        self.contentTitle.removeFromSuperview()
                        self.contentDesc.removeFromSuperview()
                        self.yourView.layoutIfNeeded()
        },
                       completion: nil
        )
    }
    
    
    

}




