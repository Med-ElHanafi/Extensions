//
//  CustomGridLayout.swift
//  Extensions
//
//  Created by Mohamed El Hanafi on 7/16/19.
//  Copyright © 2019 Mohamed El Hanafi. All rights reserved.
//

import Foundation
import UIKit

class CustomGridLayout: UICollectionViewFlowLayout {
    var numberOfColumns: Int = 3
    var cellPadding: CGFloat = 6.0
    var cache: [AnyHashable] = []
    var contentHeight: CGFloat = 0.0
    var contentWidth: CGFloat = 0.0
    var insets: UIEdgeInsets?

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard let collectionView = self.collectionView else{
            return
        }
        insets = collectionView.contentInset
        contentWidth = collectionView.bounds.size.width - (insets?.left ?? 0 + (insets?.right ?? 0))
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [AnyHashable] = []
        for column in 0..<numberOfColumns {
            xOffset.append(NSNumber(value: Float(CGFloat(column) * columnWidth)))
        }
        
        var yOffset: [AnyHashable] = []
        for _ in 0..<numberOfColumns {

            yOffset.append(NSNumber(value: 0))
        }
        
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            var frame = CGRect.zero
            switch item {
            case 0:
                frame = CGRect(x: 0, y: 0, width: columnWidth * 2, height: columnWidth * 2)
            case 1:
                frame = CGRect(x: columnWidth * 2, y: 0, width: columnWidth, height: columnWidth)
            case 2:
                frame = CGRect(x: columnWidth * 2, y: columnWidth, width: columnWidth, height: columnWidth)
            default:
                switch item % numberOfColumns {
                case 0:
                    frame = CGRect(x: 0, y: columnWidth + CGFloat(item / numberOfColumns) * columnWidth, width: columnWidth, height: columnWidth)
                case 1:
                    frame = CGRect(x: columnWidth, y: columnWidth + CGFloat(item / numberOfColumns) * columnWidth, width: columnWidth, height: columnWidth)
                default:
                    frame = CGRect(x: columnWidth * 2, y: columnWidth + CGFloat(item / numberOfColumns) * columnWidth, width: columnWidth, height: columnWidth)
                }
                break
            }
            
            let insetFrame: CGRect = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
        }
    }
    
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [AnyHashable] = []
        
        for i in 0..<cache.count {
            let attributes: UICollectionViewLayoutAttributes? = cache[i] as? UICollectionViewLayoutAttributes
            
            if (attributes?.frame.intersects(rect))! {
                if let attributes = attributes {
                    visibleLayoutAttributes.append(attributes)
                }
            }
        }
        return visibleLayoutAttributes as? [UICollectionViewLayoutAttributes]
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item] as? UICollectionViewLayoutAttributes
    }
}
