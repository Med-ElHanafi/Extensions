//
//  UIViewConstraints.swift
//  goteam
//
//  Created by Mohamed El Hanafi on 04/04/2019.
//  Copyright © 2019 Mohamed El Hanafi. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    func setConstraintConstant(_ constant: CGFloat, for attribute: NSLayoutConstraint.Attribute) -> Bool {
        let constraint = self.constraint(for: attribute)
        if constraint != nil {
            constraint?.constant = constant
            return true
        } else {
            superview!.addConstraint(NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: constant))
            return false
        }
    }
    
    func constraintConstantforAttribute(_ attribute: NSLayoutConstraint.Attribute) -> CGFloat {
        let constraint = self.constraint(for: attribute)
        
        if constraint != nil {
            return constraint?.constant ?? 0.0
        } else {
            return .nan
        }
        
    }
    
    func constraint(for attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        let fillteredArray = superview!.constraints.filter(){
            $0.firstAttribute == attribute && ($0.firstItem as? UIView) == self
        }
        
            //superview!.constraints.filter(predicate)
        if fillteredArray.count == 0 {
            return nil
        } else {
            return fillteredArray.first
        }
    }
    
    func hideView(_ hidden: Bool, by attribute: NSLayoutConstraint.Attribute) {
        if self.isHidden != hidden {
            let constraintConstant = constraintConstantforAttribute(attribute)
            
            if hidden {
                
                if !constraintConstant.isNaN {
                    alpha = constraintConstant
                } else {
                    let size = getSize
                    alpha = ((attribute == .height) ? size.height : size.width)
                }
                
                setConstraintConstant(0, for: attribute)
                self.isHidden = true
            } else {
                if !constraintConstant.isNaN {
                    self.isHidden = false
                    setConstraintConstant(alpha, for: attribute)
                    alpha = 1
                }
            }
        }
    }
    
    var getSize: CGSize {
        updateSizes()
        return CGSize(width: bounds.size.width, height: bounds.size.height)
    }

    func updateSizes() {
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func sizeToSubviews() {
        updateSizes()
        let fittingSize = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        frame = CGRect(x: 0, y: 0, width: frame.size.width, height: fittingSize.height)
    }
    
    func constrainCentered(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0)
        
        let horizontalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0)
        
        let heightContraint = NSLayoutConstraint(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.height)
        
        let widthContraint = NSLayoutConstraint(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.width)
        
        addConstraints([
            horizontalContraint,
            verticalContraint,
            heightContraint,
            widthContraint])
        
    }
    
    func constrainToEdges(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        
        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0)
        
        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0)
        
        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint])
    }
    
}
