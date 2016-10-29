//
//  YHSettingCell.swift
//  DayDayNews
//
//  Created by 马卿 on 16/10/29.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

import UIKit

class YHSettingCell: UITableViewCell {
    var switchView : UISwitch?
    var item : YHSettingItem?{
        didSet{
            switch item!.itemType {
            case .switchAccessory:
                switchView = UISwitch()
                self.accessoryView = switchView
                switchView?.addTarget(self, action: #selector(switchViewValueChanged(_:)), forControlEvents: .ValueChanged)
            default:
                accessoryType = .DisclosureIndicator
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @objc func switchViewValueChanged(sender:UISwitch)  {
        if sender.on {
            item?.option = { _ in
                print("切换为夜间模式")
            }
            item?.option!()
        }else{
            item?.option = { _ in
                print("切换为默认模式")
            }
            item?.option!()
        }
    }
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        imageView?.image = UIImage(named: item!.icon)
        textLabel?.text = item!.title
        detailTextLabel?.text = item!.detialText
    }
}
