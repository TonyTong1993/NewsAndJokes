//
//  YHProfileViewController.swift
//  DayDayNews
//
//  Created by 马卿 on 16/10/11.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

import UIKit

class YHProfileViewController: YHBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
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
extension YHPhotoViewController:UITableViewDelegate,UITableViewDataSource{
   @objc public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
   @objc public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
   @objc public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell();
    }
}