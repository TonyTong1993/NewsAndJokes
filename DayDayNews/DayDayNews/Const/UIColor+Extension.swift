//
//  UIColor+Extension.swift
//  DayDayNews
//
//  Created by 马卿 on 16/10/12.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

import UIKit

//extension UIColor {
    var randomColor : UIColor {
        return UIColor(red:CGFloat(arc4random_uniform(255))/255.0 , green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
    }
    
//}
