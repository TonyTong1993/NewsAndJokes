//
//  Bundle.swift
//  DayDayNews
//
//  Created by 马卿 on 16/10/12.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

import Foundation
extension NSBundle{
    var namespace : String {
        
        return NSBundle.mainBundle().bundleIdentifier!.componentsSeparatedByString(".").last!
    }
    
}