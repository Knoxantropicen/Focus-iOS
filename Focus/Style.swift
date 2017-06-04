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
//    static var pageColor = UIColor.lightGray
//    static var currentPageColor = UIColor.darkGray
    static var editTextColor = UIColor.white
    static var symbolColor = UIColor.red
    static var optionAlpha: CGFloat = 0.7
    
    static var settingsIcon = #imageLiteral(resourceName: "settings-light")
    static var checkIcon = #imageLiteral(resourceName: "check-light")
    static var plusIcon = #imageLiteral(resourceName: "plus-light")
    static var deleteIcon = #imageLiteral(resourceName: "delete-light")
    static var returnIcon = #imageLiteral(resourceName: "return-light")
    
    static var lightMode = true
    
    static func themeLight() {
        mainBackgroundColor = UIColor.white
        mainTextColor = UIColor.black
        popBackgroundColor = lightColor
        cellBackgroundColor = UIColor.white
        tableBackgroundColor = UIColor.white
//        pageColor = UIColor.lightGray
//        currentPageColor = UIColor.darkGray
        editTextColor = UIColor.white
        symbolColor = UIColor.red
        optionAlpha = 0.7
        
        settingsIcon = #imageLiteral(resourceName: "settings-light")
        checkIcon = #imageLiteral(resourceName: "check-light")
        plusIcon = #imageLiteral(resourceName: "plus-light")
        deleteIcon = #imageLiteral(resourceName: "delete-light")
        returnIcon = #imageLiteral(resourceName: "return-light")
        
        lightMode = true
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        UserDefaults.standard.set(true, forKey: "LightMode")
    }
    
    static func themeDark() {
        mainBackgroundColor = darkColor
        mainTextColor = UIColor.lightGray
        popBackgroundColor = dimColor
        cellBackgroundColor = dimColor
        tableBackgroundColor = darkColor
//        pageColor = dimColor
//        currentPageColor = UIColor.lightGray
        editTextColor = dimColor
        symbolColor = UIColor.lightGray
        optionAlpha = 0.4
        
        settingsIcon = #imageLiteral(resourceName: "settings-dark")
        checkIcon = #imageLiteral(resourceName: "check-dark")
        plusIcon = #imageLiteral(resourceName: "plus-dark")
        deleteIcon = #imageLiteral(resourceName: "delete-dark")
        returnIcon = #imageLiteral(resourceName: "return-dark")
        
        lightMode = false
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        UserDefaults.standard.set(false, forKey: "LightMode")
    }
}
