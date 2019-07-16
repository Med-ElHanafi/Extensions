//
//  BundleExtension.swift
//  myExtensions
//
//  Created by Mohamed El Hanafi on 7/16/19.
//  Copyright © 2019 Mohamed El Hanafi. All rights reserved.
//

import Foundation

public extension Bundle{
    static func getCurrenLanguageBundle() -> Bundle{
        let locale = Locale.preferredLanguages[0]
        let currentPath = Bundle.main.path(forResource: locale, ofType: "lproj")
        
        guard let path = currentPath else {
            return Bundle.main
        }
        let bundle = Bundle.init(path: path)
        
        return bundle!
    }
}
