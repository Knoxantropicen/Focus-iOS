//
//  Style.swift
//  Focus
//
//  Created by TianKnox on 2017/5/29.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import Foundation

struct Style {
    
    static let lightColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    static let darkColor = UIColor(red: 30/255, green: 30/255, blue: 41/255, alpha: 1)
    static let dimColor = UIColor(red: 60/255, green: 60/255, blue: 71/255, alpha: 1)
    
    static var mainBackgroundColor = UIColor.white
    static var mainTextColor = UIColor.black
    static var popBackgroundColor = lightColor
    static var cellBackgroundColor = UIColor.white
    static var tableBackgroundColor = UIColor.white
    static var editTextColor = UIColor.white
    static var symbolColor = UIColor.red
    static var optionAlpha: CGFloat = 0.7
    
    static var settingsIcon = #imageLiteral(resourceName: "settings-light")
    static var checkIcon = #imageLiteral(resourceName: "check-light")
    static var plusIcon = #imageLiteral(resourceName: "plus-light")
    
    static var lightMode = true
    
    static func themeLight() {
        mainBackgroundColor = UIColor.white
        mainTextColor = UIColor.black
        popBackgroundColor = lightColor
        cellBackgroundColor = UIColor.white
        tableBackgroundColor = UIColor.white
        editTextColor = UIColor.white
        symbolColor = UIColor.red
        optionAlpha = 0.7
        
        settingsIcon = #imageLiteral(resourceName: "settings-light")
        checkIcon = #imageLiteral(resourceName: "check-light")
        plusIcon = #imageLiteral(resourceName: "plus-light")
        
        lightMode = true
        UserDefaults.standard.set(true, forKey: "LightMode")
    }
    
    static func themeDark() {
        mainBackgroundColor = darkColor
        mainTextColor = UIColor.lightGray
        popBackgroundColor = dimColor
        cellBackgroundColor = dimColor
        tableBackgroundColor = darkColor
        editTextColor = dimColor
        symbolColor = UIColor.lightGray
        optionAlpha = 0.4
        
        settingsIcon = #imageLiteral(resourceName: "settings-dark")
        checkIcon = #imageLiteral(resourceName: "check-dark")
        plusIcon = #imageLiteral(resourceName: "plus-dark")
        
        lightMode = false
        UserDefaults.standard.set(false, forKey: "LightMode")
    }
}
