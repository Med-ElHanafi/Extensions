//
//  ViewExtensions.swift
//  Grabingo shops
//
//  Created by Mohamed El Hanafi on 01/03/2019.
//  Copyright © 2019 Mohamed El Hanafi. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
   
    /**
     This function makes a view's corners rounder
     - Parameters:
     - raduis: Pass the raduis of the corner in CGFloat, if nil is passed default value is 10.0
     
     
     ### Usage Example: ###
     ````
     view.roundedView(raduis: 6.0)
     ````
     */
    func roundedView(raduis : CGFloat?){
        guard raduis != nil else {
            self.layer.cornerRadius = 10.0
            return
        }
        self.layer.cornerRadius = raduis!
        self.clipsToBounds = true
    }
    /**
     This function makes a views corners rounder with a colored border
     - Parameters:
     - borderColor: Pass the color of the borders
     
     ### Usage Example: ###
     ````
     view.roundedViewWithBorder(borderColor: UIColor.red)
     ````
     
     */
    func roundedViewWithBorder(borderColor: UIColor){
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
    }
    
    func roundedViewWithBorder(radius :CGFloat, borderColor: UIColor, borderWidth: CGFloat){
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = radius
    }
    /**
     This function makes a view's corners rounder
     
     ### Usage Example: ###
     ````
     view.roundedView()
     ````
     */
    func roundedView(){
        self.layer.cornerRadius = 8
    }
    /**
     This function makes a view's corners rounder with shadow
     
     
     ### Usage Example: ###
     ````
     view.roundViewWithShadow()
     ````
     */
    func roundViewWithShadow(){
        self.layer.shadowColor = UIColor.gray.cgColor;
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width:0,height:2)
        
        self.layer.cornerRadius = 8
    }
    func roundViewWithShadow(offset: CGSize){
        self.layer.shadowColor = UIColor.gray.cgColor;
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = offset
        
        self.layer.cornerRadius = 8
    }
    func roundViewWithShadow(raduis : CGFloat, shadowColor:UIColor,shadowRaduis : CGFloat){
        self.layer.shadowColor = shadowColor.cgColor;
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = shadowRaduis
        self.layer.shadowOffset = CGSize(width:0,height:2)
        
        self.layer.cornerRadius = raduis
    }
    
    func addShadow(shadowColor:UIColor,shadowRaduis : CGFloat)  {
       
        self.layer.shadowColor = shadowColor.cgColor;
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = shadowRaduis
        self.layer.shadowOffset = CGSize(width:3,height:3)
    }
    
    
    /**
     This function adds a gradient layer to a view
     - Parameters:
     - colors: An array of CGColor to define gradient colors applied on the view's layer
     
     
     ### Usage Example: ###
     ````
     view.addGradientLayerToView(colors: [UIColor.greenAccentColor().cgColor,UIColor.grabingoGreenColor().cgColor])
     ````
     */
    func addGradientLayerToView(colors :[CGColor]){
        let layer = CAGradientLayer();
        layer.frame = self.bounds;
        layer.startPoint = CGPoint(x:0.0,y: 0.5)
        layer.endPoint = CGPoint(x:1.0,y: 0.5)
        layer.colors = colors;
        self.layer .insertSublayer(layer, at: 0)
    }
    /**
     This function adds a gradient layer to a view with shadow
     - Parameters:
     - colors: An array of CGColor to define gradient colors applied on the view's layer
     - shadowColor: the color of the shadow applied on the view
     
     
     ### Usage Example: ###
     ````
     view.addGradientLayerToView(colors: [UIColor.greenAccentColor().cgColor,UIColor.grabingoGreenColor().cgColor], withShadowd: UIColor.gray)
     ````
     */
    func addGradientLayerToView(colors : [CGColor], withShadowd shadowColor:UIColor)  {
        let layer = CAGradientLayer();
        layer.frame = self.bounds
        layer.startPoint = CGPoint(x:0.0,y: 0.5)
        layer.endPoint = CGPoint(x:1.0,y: 0.5)
        layer.colors = colors;
        layer.cornerRadius = 10
        
        self.layer .insertSublayer(layer, at: 0)
        
        self.layer.shadowColor = shadowColor.cgColor;
        self.layer.shadowOpacity = 0.6;
        self.layer.shadowRadius = 10.0;
        self.layer.shadowOffset = CGSize(width:0,height:0)

        self.layer.cornerRadius = 10
    }
    
    func horizontalShakeAnimation(value: CGFloat, completion: (()->Void)?) {
        CATransaction.begin()
        let animation = CABasicAnimation.init(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: self.center.x - value, y: self.center.y)
        animation.toValue = CGPoint(x: self.center.x + value, y: self.center.y)
        
        if let completion = completion{
            CATransaction.setCompletionBlock(completion)
        }
        
        self.layer.add(animation, forKey: "position")
        CATransaction.commit()
    }
    
    func roundViewCorners(fromSide corners: UIRectCorner, withRaduis radius: CGFloat) {
        let bezierPath = UIBezierPath(roundedRect: self.bounds , byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        
        self.layer.mask = shapeLayer
    }
}

public extension UILabel{
    /**
     This function makes a label's text underlined
     - Parameters:
     - text: the String to add underline to
     
     
     ### Usage Example: ###
     ````
     myLabel.underlineText(text: "Hello")
     ````
     */
    func underlineText(text: String){
        let textRange = NSMakeRange(0, text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        // Add other attributes if needed
        self.attributedText = attributedText
    }
}

