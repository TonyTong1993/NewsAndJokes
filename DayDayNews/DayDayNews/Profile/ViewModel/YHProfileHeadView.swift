//
//  YHProfileHeadView.swift
//  DayDayNews
//
//  Created by 马卿 on 16/10/29.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

import UIKit
class YHProfileHeadView: UIView {
    let loginViewH : CGFloat = 120.0
    let resignBtnW : CGFloat = 40.0
    let resignBtnH : CGFloat = 20.0
    let resignBtnTopAndRightEdage : CGFloat = 30.0
    
   lazy var loginView : YHLoginView  = {
        let loginView = YHLoginView()
        loginView.translatesAutoresizingMaskIntoConstraints = false;
       return loginView
    }()
   lazy var resignBtn : UIButton = {
        let resignBtn = UIButton()
        resignBtn.setTitle("注销", forState: .Normal);
        resignBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        //为了不和autosizing冲突，我们设置No
        resignBtn.translatesAutoresizingMaskIntoConstraints = false;
    
        return resignBtn
       
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loginView)
        addSubview(resignBtn)
        resignBtn.addTarget(self, action: #selector(resignBtnClicked), forControlEvents: .TouchUpInside)
        //布局
        addConstraint(NSLayoutConstraint(item: loginView, attribute: .CenterX, relatedBy: .Equal, toItem:self, attribute: .CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginView, attribute: .CenterY, relatedBy: .Equal, toItem:self, attribute: .CenterY, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginView, attribute:.Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: loginViewH))
        addConstraint(NSLayoutConstraint(item: loginView, attribute:.Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: loginViewH))
        
        addConstraint(NSLayoutConstraint(item: resignBtn, attribute: .Top, relatedBy: .Equal, toItem:self, attribute: .Top, multiplier: 1.0, constant: resignBtnTopAndRightEdage))
        addConstraint(NSLayoutConstraint(item: resignBtn, attribute: .Right, relatedBy: .Equal, toItem:self, attribute: .Right, multiplier: 1.0, constant: -resignBtnTopAndRightEdage))
        addConstraint(NSLayoutConstraint(item: resignBtn, attribute:.Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: resignBtnW))
        addConstraint(NSLayoutConstraint(item: resignBtn, attribute:.Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: resignBtnH))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   @objc func resignBtnClicked()  {
    print("resignBtnClicked");
    }
    
    
    
    
}
