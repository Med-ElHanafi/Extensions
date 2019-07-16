//
//  StringExtensions.swift
//  goteam
//
//  Created by Mohamed El Hanafi on 25/03/2019.
//  Copyright © 2019 Mohamed El Hanafi. All rights reserved.
//

import UIKit

// MARK: Localizable
public protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    /**
     This property makes using localized string easier
     ### Usage Example: ###
     ````
     let text = "ok_key".localized
     ````
     */
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.getCurrenLanguageBundle(), value: "", comment: "")
        //NSLocalizedStringFromTableInBundle(@"change_language_alert_msg", nil,[Utils getCurrentLanguageBundle], nil)
        
        //return NSLocalizedString(self, comment: "")
    }
    func toLengthOf(length:Int) -> String {
        if length <= 0 {
            return self
        } else if let to = self.index(self.startIndex, offsetBy: length, limitedBy: self.endIndex) {
            return self.substring(from: to)
            
        } else {
            return ""
        }
    }
    func extractYoutubeIdFromLink() -> String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        guard let regExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return nil
        }
        let nsLink = self as NSString
        let options = NSRegularExpression.MatchingOptions(rawValue: 0)
        let range = NSRange(location: 0, length: nsLink.length)
        let matches = regExp.matches(in: self, options:options, range:range)
        if let firstMatch = matches.first {
            return nsLink.substring(with: firstMatch.range)
        }
        return nil
    }
}
public extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

// MARK: XIBLocalizable
public protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}
/// Extension for UILabel Localization in xib
extension UILabel: XIBLocalizable {
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}
/// Extension for UINavigationItem Localization in xib
extension UINavigationItem: XIBLocalizable {
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized
        }
    }
}
/// Extension for UIBarItem Localization in xib
extension UIBarItem: XIBLocalizable { // Localizes UIBarButtonItem and UITabBarItem
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized
        }
    }
}

// MARK: Special protocol to localize multiple texts in the same control
public protocol XIBMultiLocalizable {
    var xibLocKeys: String? { get set }
}
/// Extension for UISegmentedControl Localization in xib
extension UISegmentedControl: XIBMultiLocalizable {
    @IBInspectable public var xibLocKeys: String? {
        get { return nil }
        set(keys) {
            guard let keys = keys?.components(separatedBy: ","), !keys.isEmpty else { return }
            for (index, title) in keys.enumerated() {
                setTitle(title.localized, forSegmentAt: index)
            }
        }
    }
}

// MARK: Special protocol to localizaze UITextField's placeholder
public protocol UITextFieldXIBLocalizable {
    var xibPlaceholderLocKey: String? { get set }
}
/// Extension for UITextField Localization in xib
extension UITextField: UITextFieldXIBLocalizable {
    @IBInspectable public var xibPlaceholderLocKey: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized
        }
    }
}

// MARK: XIBLocalizable
public protocol XIBButtonLocalizable {
    var xibButtonNormalLocKey: String? { get set }
    var xibButtonSelectedLocKey: String? { get set }
    var xibButtonHighlightedLocKey: String? { get set }
    var xibButtonDisabledLocKey: String? { get set }
}

/// Extension for UIButton Localization in xib
extension UIButton: XIBButtonLocalizable {
 
    @IBInspectable public var xibButtonNormalLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
    }
    
    @IBInspectable public var xibButtonSelectedLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .selected)
        }
    }
    
    @IBInspectable public var xibButtonHighlightedLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .highlighted)
        }
    }
    
    @IBInspectable public var xibButtonDisabledLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .disabled)
        }
    }
}


