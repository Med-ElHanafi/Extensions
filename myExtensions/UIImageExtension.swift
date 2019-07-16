//
//  UIImageExtension.swift
//  goteam
//
//  Created by Mohamed El Hanafi on 29/03/2019.
//  Copyright © 2019 Mohamed El Hanafi. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    /// This function returns a resized image depending on the passed percentage in parameter
    ///
    /// - Parameter percentage: percentage as CGFloat
    /// - Returns: the resized image
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// This function returns a resized image depending on the passed percentage in parameter
    ///
    /// - Parameter width: the desired width
    /// - Returns: the resized image
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
    /// This function returns a circular image with colored border
    ///
    /// - Parameters:
    ///   - size: the desired size
    ///   - borderColor: color of the border
    /// - Returns: the returned image
    /**
     
     ### Usage Example: ###
     ````
     let image = img.circularImage(size: CGSize(width: 35, height: 35),borderColor: color)
     ````
     */
    func circularImage(size: CGSize?,borderColor: UIColor?) -> UIImage {
        let newSize = size ?? self.size
        
        let minEdge = min(newSize.height, newSize.width)
        let size = CGSize(width: minEdge, height: minEdge)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        self.draw(in: CGRect(origin: CGPoint.zero, size: size), blendMode: .copy, alpha: 1.0)
        
        context!.setBlendMode(.copy)
        context!.setFillColor(UIColor.clear.cgColor)
        
        
        
        let rectPath = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: size))
        let circlePath = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: size))
        
        
        //Added for border
        if let borderColor = borderColor{
            borderColor.setStroke()
            circlePath.lineWidth = 2
            circlePath.stroke()
        }
        
        
        rectPath.append(circlePath)
        rectPath.usesEvenOddFillRule = true
        rectPath.fill()
        
        
        
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return result
    }
}
