//
//  AppDelegate.swift
//  DayDayNews
//
//  Created by 马卿 on 16/9/28.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    /// Saved shortcut item used as a result of an app launch, used later when app is activated.
    var launchedShortcutItem: UIApplicationShortcutItem?
    // MARK: - 静态属性
    
    static let applicationShortcutUserInfoIconKey = "applicationShortcutUserInfoIconKey"

    var window: UIWindow?
    //指定数据类型的枚举
    enum ShortcutIdentifier : String {
        case First
        case Second
        case Third
        //构造函数
        init?(fullType:String) {
            guard let last = fullType.componentsSeparatedByString(".").last else { return nil }
            self.init(rawValue:last)
        }
        //枚举属性
        var type : String {
              return NSBundle.mainBundle().bundleIdentifier! + ".\(self.rawValue)"
        }
        
    }
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        // Verify that the provided `shortcutItem`'s `type` is one handled by the application.
        guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else { return false }
        
        guard let shortCutType = shortcutItem.type as String? else { return false }
        
        switch (shortCutType) {
        case ShortcutIdentifier.First.type:
            // Handle shortcut 1 (static).
            handled = true
            break
        case ShortcutIdentifier.Second.type:
            // Handle shortcut 2 (static).
            handled = true
            break
        case ShortcutIdentifier.Third.type:
            // Handle shortcut 3 (dynamic).
            handled = true
            break
            default:
            break
        }
        
        // Construct an alert using the details of the shortcut used to open the application.
        let alertController = UIAlertController(title: "Shortcut Handled", message: "\"\(shortcutItem.localizedTitle)\"", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        
        // Display an alert indicating the shortcut selected from the home screen.
        window!.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
        return handled
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        var shouldPerformAdditionalDelegateHandling = true
        
        // If a shortcut was launched, display its information and take the appropriate action
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            
            launchedShortcutItem = shortcutItem
            
            // This will block "performActionForShortcutItem:completionHandler" from being called.
            shouldPerformAdditionalDelegateHandling = false
        }
        window = UIWindow()
        //window?.backgroundColor = UIColor.whiteColor()
        let vc = YHRootViewController()
        vc.view.backgroundColor = UIColor.blueColor()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        //初次进入需要注册shortcutItems
       if let shortcutItems = application.shortcutItems where shortcutItems.isEmpty {
        let dict0 = ["type":ShortcutIdentifier.First.type,
                     "localizedTitle":"Album",
                     "localizedSubtitle":"美好的回忆",
                     "icon":UIApplicationShortcutIcon(type: .Location),
                     "userInfo":[:]]
        let dict1 = ["type":ShortcutIdentifier.Second.type,
                     "localizedTitle":"News",
                     "localizedSubtitle":"发生的实时",
                     "icon":UIApplicationShortcutIcon(type: .Contact),
                     "userInfo":[:]]
        let dict3 = ["type":ShortcutIdentifier.Third.type,
                     "localizedTitle":"Jokey",
                     "localizedSubtitle":"内涵段子",
                     "icon":UIApplicationShortcutIcon(type: .Favorite),
                     "userInfo":[:]]
        let array = [dict0,dict1,dict3];
        for dict in array {
            guard let type = dict["type"] as? String ,
                let localizedTitle = dict["localizedTitle"] as? String,
                let localizedSubtitle = dict["localizedSubtitle"] as? String,
                let icon = dict["icon"] as? UIApplicationShortcutIcon,
                let userInfo = dict["userInfo"] as? [String:AnyObject]?
                else{
                    break
            }
            creatShortcutItems(type, localizedTitle: localizedTitle, localizedSubtitle: localizedSubtitle, icon: icon, userInfo: userInfo);
        }
    }


        return shouldPerformAdditionalDelegateHandling
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        guard let shortcut = launchedShortcutItem else { return }
        
        handleShortCutItem(shortcut)
        
        launchedShortcutItem = nil
    }
    //3D touch Home Screen Quick Actions 入口
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        
         completionHandler(handledShortCutItem)
    }
    //MARK:Create Home Screen Quick shortcutItems
    func creatShortcutItems(type:String,localizedTitle:String,localizedSubtitle:String?,icon:UIApplicationShortcutIcon,userInfo:[String:AnyObject]?)  {
        
        let shortcutItem = UIMutableApplicationShortcutItem(type: type,
                                                            localizedTitle: localizedTitle, localizedSubtitle: localizedSubtitle, icon: icon, userInfo: userInfo)
        UIApplication.sharedApplication().shortcutItems?.append(shortcutItem);
    }

}

