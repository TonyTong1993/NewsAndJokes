//
//  YHProfileViewController.swift
//  DayDayNews
//
//  Created by 马卿 on 16/10/11.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

import UIKit

class YHProfileViewController: YHBaseViewController {
    var dataSource : [YHSettingGroup]?
    let ID = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionItem =  YHSettingItem(icon: "MorePush", title: "收藏", itemType: .arrowAccessory)
        collectionItem.option = { _ in
            print("collectionItem")
        }
        let nightModeItem =  YHSettingItem(icon: "handShake", title: "夜间模式", itemType: .switchAccessory)
        let firstItems = [collectionItem,nightModeItem]
        let helpItem = YHSettingItem(icon: "MoreHelp", title: "帮助与反馈", itemType: .arrowAccessory)
        helpItem.detialText = "0"
        helpItem.option = { _ in
        print("helpItem")
        }
        let shareItem = YHSettingItem(icon: "MoreShare", title: "分享给好友", itemType: .arrowAccessory)
        shareItem.option = { _ in
            print("shareItem")
        }
        let clearItem = YHSettingItem(icon: "handShake", title: "清除缓存", itemType: .arrowAccessory)
        clearItem.option = { _ in
            print("clearItem")
        }
         clearItem.detialText = "100M"
        let aboutItem = YHSettingItem(icon: "MoreAbout", title: "关于", itemType: .arrowAccessory)
        aboutItem.option = { _ in
            print("aboutItem")
        }
        let secondItems = [helpItem,shareItem,clearItem,aboutItem]
        let groupZero = YHSettingGroup(items: firstItems)
        let groupOne = YHSettingGroup(items: secondItems)
        dataSource = [YHSettingGroup]()
        dataSource?.append(groupZero)
        dataSource?.append(groupOne)
        
        
    }
    override func setUpTableView() {
        //设置 tableHeaderView
        tableView = UITableView(frame: view.bounds, style: .Grouped )
        tableView?.backgroundColor = randomColor
        //实现数据源、代理方法
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
        let rect = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height/3);
        let headerView = YHProfileHeadView(frame: rect);
        headerView.backgroundColor = randomColor
        tableView?.tableHeaderView = headerView;
    
        
    }
    
}
extension YHProfileViewController{
    @objc  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let dataSource = dataSource else{
            return 0
        }
        return dataSource.count
    }
    @objc  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else{
            return 0
        }
        let group = dataSource[section]
        return group.items.count
    }
    
    @objc  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = dataSource![indexPath.section].items[indexPath.row];
        let cell = YHSettingCell(style: .Value1, reuseIdentifier: ID)
        cell.item = item
        return cell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        let item = dataSource![indexPath.section].items[indexPath.row];
        guard let option = item.option else{
            return
            
        }
        switch item.itemType {
        case .arrowAccessory:
            option()
        default:
            break
        }
        
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
}