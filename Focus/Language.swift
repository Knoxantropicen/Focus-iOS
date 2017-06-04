//
//  Language.swift
//  Focus
//
//  Created by TianKnox on 2017/5/29.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import Foundation

struct Language {
    
    static let englishMainModel = "Start typing here..."
    static let chineseMainModel = "在此处输入..."
    static let englishEditModel = "Click 'Edit' to add description..."
    static let chineseEditModel = "点击'修改'增加描述..."
    
    static var doing = "Doing Now"
    static var done = "Already Done"
    static var mainModel = englishMainModel
    static var description = "Description"
    static var close = "Close"
    static var edit = "Edit"
    static var editModel = englishEditModel
    static var settings = "Settings"
    static var notification = "Notification"
    static var timeInterval = "Time Interval"
    static var theme = "Theme"
    static var language = "Language"
    static var light = "Light"
    static var dark = "Dark"
    static var english = "ENG"
    static var chinese = "CHN"
    static var save = "Save"
    
    static var createAction = "Added to 'Doing Now'"
    static var finishAction = "Added to 'Already Done'"
    
    static var replaceAlert = "Replace the unfinished task in focus?"
    static var deleteConfirmation = "Delete all items from 'Already Done'?"
    static var yes = "Yes"
    static var cancel = "Cancel"
    
    static var widgetModel = "Nothing in focus..."
    
    static var EnglishLanguage = true
    
    static func setEnglish() {
        doing = "Doing Now"
        done = "Already Done"
        mainModel = englishMainModel
        description = "Description"
        close = "Close"
        edit = "Edit"
        editModel = englishEditModel
        settings = "Settings"
        notification = "Notification"
        timeInterval = "Time Interval"
        theme = "Theme"
        language = "Language"
        light = "Light"
        dark = "Dark"
        english = "ENG"
        chinese = "CHN"
        save = "Save"
        
        createAction = "Added to 'Doing Now'"
        finishAction = "Added to 'Already Done'"
        
        replaceAlert = "Replace the unfinished task in focus?"
        deleteConfirmation = "Delete all items from 'Already Done'?"
        yes = "Yes"
        cancel = "Cancel"
        
        widgetModel = "Nothing in focus..."
        
        EnglishLanguage = true
        UserDefaults.standard.set(true, forKey: "EnglishLanguage")
    }
    
    static func setChinese() {
        doing = "进行中"
        done = "已完成"
        mainModel = chineseMainModel
        description = "描述"
        close = "关闭"
        edit = "修改"
        editModel = chineseEditModel
        settings = "设置"
        notification = "通知功能"
        timeInterval = "提醒时间间隔"
        theme = "主题"
        language = "语言"
        light = "昼"
        dark = "夜"
        english = "英"
        chinese = "中"
        save = "保存"
        
        createAction = "已添加到'进行中'"
        finishAction = "已添加到'已完成'"
        
        replaceAlert = "确认替换未完成的主事务?"
        deleteConfirmation = "确认清空'已完成'?"
        yes = "确认"
        cancel = "取消"
        
        widgetModel = "主事务为空..."
        
        EnglishLanguage = false
        UserDefaults.standard.set(false, forKey: "EnglishLanguage")
    }
}
