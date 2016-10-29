//
//  YHswift
//  DayDayNews
//
//  Created by 马卿 on 16/10/29.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

import UIKit

class YHLoginView: UIView {
    var avaterView : UIImageView?
    var titleLabel : UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true;
        avaterView = UIImageView()
        let icon = UIImage(named: "comment_profile_default")?.imageWithRenderingMode(.AlwaysOriginal);
        avaterView?.image = icon
        avaterView?.layer.cornerRadius = 35
        avaterView?.layer.masksToBounds = true
        titleLabel = UILabel()
        titleLabel?.text = "立即登录"
        titleLabel?.textColor = UIColor.whiteColor()
        avaterView?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(avaterView!);
        addSubview(titleLabel!);
        //布局
        addConstraint(NSLayoutConstraint(item: avaterView!, attribute:.Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 10));
        addConstraint(NSLayoutConstraint(item: avaterView!, attribute:.CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0));
        addConstraint(NSLayoutConstraint(item: avaterView!, attribute:.Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 70));
        addConstraint(NSLayoutConstraint(item: avaterView!, attribute:.Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 70));
        
        addConstraint(NSLayoutConstraint(item: titleLabel!, attribute:.Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: -10));
        addConstraint(NSLayoutConstraint(item: titleLabel!, attribute:.CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0));
        
        let tapGesture =  UITapGestureRecognizer(target: self, action: #selector(loginViewClicked))
        addGestureRecognizer(tapGesture);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   @objc func loginViewClicked() {
        print("loginViewClicked")
    }
}
