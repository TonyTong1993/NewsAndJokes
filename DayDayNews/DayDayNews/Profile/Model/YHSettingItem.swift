//
//  YHSettingItem.swift
//  DayDayNews
//
//  Created by 马卿 on 16/10/29.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

import Foundation
class YHSettingItem {
    typealias Option = ()->()
    enum YHSettingItemAccessoryType : Int{
        case switchAccessory
        case arrowAccessory
    }
    var icon : String
    var title : String
    var itemType : YHSettingItemAccessoryType
    var option : Option?
    var detialText : String?
    init(icon:String ,title:String, itemType:YHSettingItemAccessoryType){
        self.icon = icon
        self.title = title
        self.itemType = itemType
    }
    convenience init(){
        self.init()
    }
    
}
class YHSettingGroup{
    var items : [YHSettingItem]
    init(items:[YHSettingItem]){
        self.items = items
    }
    convenience init(){
        self.init()
    }
  
}